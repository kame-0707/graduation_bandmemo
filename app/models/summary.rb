class Summary < ApplicationRecord
  belongs_to :user
  validates :summary, presence: true
  validates :content, presence: true
end
