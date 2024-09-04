FactoryBot.define do
  factory :video do
    sequence(:title) { |n| "タイトル#{n}" }
    sequence(:videos_url) { |n| "https://www.youtube.com/embed/#{n}" }
    association :user
    association :group
  end
end
