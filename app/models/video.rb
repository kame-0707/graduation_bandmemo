class Video < ApplicationRecord
belongs_to :user
belongs_to :group

validates :title, presence: true
validates :videos_url, presence: true
end
