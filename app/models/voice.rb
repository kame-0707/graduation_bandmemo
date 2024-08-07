class Voice < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  validates :content, presence: true
end
