FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "コメント#{n}" }
    association :user
    association :group
    association :summary
  end
end
