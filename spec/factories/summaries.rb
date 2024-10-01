# frozen_string_literal: true

FactoryBot.define do
  factory :summary do
    sequence(:title) { |n| "タイトル#{n}" }
    sequence(:content) { |n| "本文#{n}" }
    sequence(:summary) { |n| "要約#{n}" }
    association :user
    association :group
  end
end
