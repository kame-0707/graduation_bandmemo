# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :summaries, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :voices, dependent: :destroy
  has_many :spots, dependent: :destroy
  has_many :videos, dependent: :destroy

  has_many :group_users, dependent: :destroy
  has_many :permits, dependent: :destroy
  has_many :groups, through: :group_users

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  validates :reset_password_token, uniqueness: true, allow_nil: true

  def own?(object)
    id == object&.user_id
  end
end
