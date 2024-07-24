class VideosController < ApplicationController
  def index
    @videos = @group.videos.includes(:user).order(created_at: :desc)
  end
end
