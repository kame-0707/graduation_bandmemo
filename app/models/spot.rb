# frozen_string_literal: true

class Spot < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :registered_title, presence: true, length: { maximum: 255 }
  validates :start_datetime, presence: true
end
