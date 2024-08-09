# frozen_string_literal: true

class Spot < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  validates :lat, presence: true
  validates :lng, presence: true
end
