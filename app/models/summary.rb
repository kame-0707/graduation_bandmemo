class Summary < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
end
