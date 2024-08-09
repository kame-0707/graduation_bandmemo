# frozen_string_literal: true

class Permit < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
