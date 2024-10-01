# frozen_string_literal: true

FactoryBot.define do
  factory :voice do
    sequence(:content) { |n| "音声#{n}" }
    association :user
    association :group
  end
end
