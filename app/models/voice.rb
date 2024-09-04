# frozen_string_literal: true

class Voice < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  validates :content, presence: true, length: { maximum: 65_535 }
end
