FactoryBot.define do
  factory :message do
    body { "Hello world" }
    user
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@email.com" }
    sequence(:name) { |n| "User #{n}" }
    password { '12345678' }
  end
end
