class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :group, optional: true
    belongs_to :summary

    validates :content, presence: true
end
