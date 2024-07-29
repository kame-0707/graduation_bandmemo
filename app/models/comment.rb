class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :group
    belongs_to :summary

    validates :content, presence: true
end
