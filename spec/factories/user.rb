FactoryBot.define do
  factory :user do
    sequence(:email)  { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Time.current } # メール認証済みにする
  end
end