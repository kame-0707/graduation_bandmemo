# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :summaries, dependent: :destroy
  has_many :voices, dependent: :destroy
  has_many :spots, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :permits, dependent: :destroy
  has_many :users, through: :group_users

  validates :name, presence: true
end
