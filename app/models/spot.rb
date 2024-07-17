class Spot < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :latitude, presence: true
  validates :longitude, presence: true
end
