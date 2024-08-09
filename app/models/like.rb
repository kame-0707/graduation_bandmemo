# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  belongs_to :summary
end
