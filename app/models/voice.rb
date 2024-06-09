class Voice < ApplicationRecord
  validates :content, presence: true
end
