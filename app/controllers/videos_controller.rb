# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :set_video, only: %i[edit update destroy]
  before_action :set_group
  before_action :authorize_user!
  before_action :authorize_owner!, only: %i[edit update destroy]

  def index
    @videos = @group.videos.includes(:user).order(created_at: :desc)
  end

  def new
    @video = @group.videos.new
  end

  def edit; end

  def create
    @video = @group.videos.new(video_params.merge(user: current_user))
    if @video.save
      redirect_to group_videos_path(@group), notice: '動画が投稿されました'
    else
      flash.now[:alert] = '動画を投稿できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @video.update(video_params)
      redirect_to group_videos_path(@group, @video), notice: '動画が更新されました'
    else
      flash.now[:alert] = '動画を更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    video = @video
    video.destroy!
    redirect_to group_videos_path(@group), status: :see_other, notice: '動画が削除されました'
  end

  private

  def set_video
    @group = Group.find(params[:group_id])
    @video = @group.videos.find(params[:id])
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
    @video = @group.videos.find(params[:id])
    @group = Group.find(params[:group_id])
    return if @video.user == current_user

    redirect_to group_videos_path(@group), alert: '操作の権限がありません'
  end

  def video_params
    params.require(:video).permit(:title, :videos_url)
  end
end
