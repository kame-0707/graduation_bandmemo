# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  belongs_to :summary

  validates :content, presence: true, length: { maximum: 255 }
end
