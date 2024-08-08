class PersonalVideosController < ApplicationController
  before_action :set_video, only: %i[edit update destroy]

  def index
    @videos = current_user.videos.includes(:user).order(created_at: :desc)
  end

  def new
    @video = current_user.videos.new
  end

  def create
    @video = current_user.videos.new(video_params)
    @video.group_id = nil unless params[:video][:group_id].present?
    if @video.save
      redirect_to personal_videos_path, notice: '動画が投稿されました'
    else
      flash.now[:alert] = '動画を投稿できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @video.update(video_params)
      redirect_to personal_videos_path(@video), notice: '動画が更新されました'
    else
      flash.now[:alert] = '動画を更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    video = @video
    video.destroy!
    redirect_to personal_videos_path, status: :see_other, notice: '動画が削除されました'
  end

  private

  def set_video
    @video = current_user.videos.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :videos_url)
  end
end
