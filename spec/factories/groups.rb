FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "タイトル#{n}" }
    sequence(:introduction) { |n| "紹介文#{n}" }
  end
end
