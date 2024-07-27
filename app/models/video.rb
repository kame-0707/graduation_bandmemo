class Video < ApplicationRecord
    belongs_to :user
    belongs_to :group

    validates :title, presence: true
    validates :videos_url, presence: true

    def split_id_from_youtube_url
        # YoutubeならIDのみ抽出
        videos_url.split('/').last
    end
end
