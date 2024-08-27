# frozen_string_literal: true

class Summary < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65_535 }
  validates :summary, presence: true, length: { maximum: 65_535 }
end
