FactoryBot.define do
  factory :user do
    name { "taro" }
    email { "sample@test.com" }
    password_digest { "password" }
  end
end
