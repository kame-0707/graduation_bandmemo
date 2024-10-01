# frozen_string_literal: true

class PersonalSummariesController < ApplicationController
  before_action :set_summary, only: %i[edit update destroy]

  def index
    @summaries = current_user.summaries.where(group_id: nil).order(created_at: :desc)
  end

  def show
    @summary = current_user.summaries.where(group_id: nil).find(params[:id])
    @comment = Comment.new
    @comments = @summary.comments.includes(:user).order(created_at: :desc)
  end

  def original
    @summary = current_user.summaries.find(params[:id])
    return if @summary.user_id == current_user.id

    redirect_to personal_summaries_path, alert: '原文を確認できるのは投稿者のみです'
  end

  def new
    @summary = current_user.summaries.new
  end

  def edit; end

  def create
    input_content = summary_params[:content]

    @summary = if params[:commit] == 'AI要約して保存'
                 summary_text = OpenaiService.new(input_content).call
                 current_user.summaries.new(title: summary_params[:title], content: summary_params[:content],
                                            summary: summary_text, user: current_user)
               elsif params[:commit] == 'そのまま保存'
                 current_user.summaries.new(title: summary_params[:title], content: input_content,
                                            summary: nil, user: current_user)
               end
    @summary.group_id = nil if params[:summary][:group_id].blank?

    if @summary&.save
      redirect_to personal_summaries_path, notice: 'メモが保存されました'
    else
      flash.now[:alert] = 'メモの保存ができませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @summary.update(summary_params)
      redirect_to personal_summaries_path(@summary), notice: 'メモが更新されました'
    else
      flash.now[:alert] = 'メモを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    summary = @summary
    summary.destroy!
    redirect_to personal_summaries_path, status: :see_other, notice: 'メモが削除されました'
  end

  private

  def set_summary
    @summary = current_user.summaries.where(group_id: nil).find(params[:id])
  end

  def summary_params
    params.require(:summary).permit(:content, :summary, :title)
  end
end
