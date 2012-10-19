FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "name#{n}" }
    sequence(:email) { |n| "email.#{n}@example.com" }
    password              "password"
    password_confirmation "password"
    first_name            "John"
    last_name             "Doe"
  end
end
