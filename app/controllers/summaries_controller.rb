# frozen_string_literal: true

class SummariesController < ApplicationController
  before_action :set_summary, only: %i[edit update destroy]
  before_action :set_group
  before_action :authorize_user!
  before_action :authorize_owner!, only: %i[edit update destroy]

  def index
    @summaries = @group.summaries.includes(:user).order(created_at: :desc)
  end

  def show
    @summary = @group.summaries.find(params[:id])
    @comment = Comment.new
    @comments = @summary.comments.includes(:user).order(created_at: :desc)
  end

  def original
    @summary = @group.summaries.find(params[:id])
    return if @summary.user_id == current_user.id

    redirect_to group_summaries_path(@group), alert: '原文を確認できるのは投稿者のみです'
  end

  def new
    @summary = @group.summaries.new
  end

  def edit; end

  def create
    input_content = summary_params[:content]

    @summary = if params[:commit] == 'AI要約して保存'
                 summary_text = OpenaiService.new(input_content).call
                 @group.summaries.new(title: summary_params[:title], content: input_content,
                                      summary: summary_text, user: current_user)
               elsif params[:commit] == 'そのまま保存'
                 @group.summaries.new(title: summary_params[:title], content: input_content,
                                      summary: nil, user: current_user)
               end

    if @summary&.save
      redirect_to group_summaries_path(@group), notice: 'メモが保存されました'
    else
      flash.now[:alert] = 'メモの保存ができませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @summary.update(summary_params)
      redirect_to group_summaries_path(@group, @summary), notice: 'メモが更新されました'
    else
      flash.now[:alert] = 'メモを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    summary = @summary
    summary.destroy!
    redirect_to group_summaries_path(@group), status: :see_other, notice: 'メモが削除されました'
  end

  private

  def set_summary
    @group = Group.find(params[:group_id])
    @summary = @group.summaries.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def authorize_user!
    @group = Group.find(params[:group_id])
    return if current_user.groups.include?(@group)

    redirect_to root_path, alert: 'グループメンバーとして承認されていません'
  end

  def authorize_owner!
    @summary = @group.summaries.find(params[:id])
    @group = Group.find(params[:group_id])
    return if (@summary.user_id == current_user.id) || (@group.owner_id == current_user.id)

    redirect_to group_summaries_path(@group), alert: '編集・削除ができるのは投稿者とオーナーのみです'
  end

  def summary_params
    params.require(:summary).permit(:content, :summary, :title)
  end
end
