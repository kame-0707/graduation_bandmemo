class Spot < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :lat, presence: true
  validates :lng, presence: true
end
