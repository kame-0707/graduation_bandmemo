# frozen_string_literal: true

FactoryBot.define do
  factory :group_user do
    association :user
    association :group
  end
end
