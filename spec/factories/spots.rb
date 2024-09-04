FactoryBot.define do
  factory :spot do
    lat { "35.6819333778112" }
    lng { "139.76703896931386" }
    sequence(:registered_title) { |n| "タイトル#{n}" }
    start_datetime { "2024-12-31 23:59:59" }
    association :user
    association :group
  end
end
