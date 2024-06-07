class Summary < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :summary, presence: true
  validates :content, presence: true
end
