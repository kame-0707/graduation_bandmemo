# frozen_string_literal: true

class Video < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  validates :title, presence: true, length: { maximum: 255 }
  validates :videos_url, presence: true, length: { maximum: 255 }

  def split_id_from_youtube_url
    # YoutubeのIDのみ抽出
    videos_url.split('/').last
  end
end
