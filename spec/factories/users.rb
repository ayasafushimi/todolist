FactoryBot.define do
  factory :user do
    name { "taro" }
    email { "sample@test.com" }
    password_digest { "password" }

    # Todo作成済みのユーザー
    trait :with_todos do
      after(:create) {|user| create_list(:todo, 5, user: user)}
    end
  end
end
