require 'factory_girl'

FactoryGirl.define do

  sequence :email do |n|
    "email.#{n}@example.com"
  end

  sequence :title do |n|
    "title #{n}"
  end

  sequence :name do |n|
    "name#{n}"
  end

  sequence :number do |n|
    n
  end

  factory :user do
    login                 { FactoryGirl.generate(:name) }
    email                 { FactoryGirl.generate(:email) }
    password              "password"
    password_confirmation "password"
    first_name            "John"
    last_name             "Doe"
  end

  factory :family do
    name    { FactoryGirl.generate(:name) }
    head    { FactoryGirl.create(:user) }
  end

  factory :category do
    name  { FactoryGirl.generate(:title) }

    factory :spend_category do
      type "SpendCategory"
    end

    factory :income_category do
      type "IncomeCategory"
    end

    factory :credit_category do
      type "CreditCategory"
    end

    factory :plan_category do
      type "PlanCategory"
    end

  end

  factory :operation do
    creator { FactoryGirl.create(:user) }

    factory :money_operation do
      type    "MoneyOperation"

      factory :spending_operation do
        amount -10000
      end

      factory :incoming_operation do
        amount 10000
      end
    end

    factory :credit_operation do
      type   "CreditOperation"

      factory :lend_operation do
        amount -10000
      end

      factory :take_credit_operation do
        amount 10000
      end
    end

    factory :plan_operation do
      type   "PlanOperation"

      factory :plan_spending_operation do
        amount -10000
      end

      factory :plan_incoming_operation do
        amount 10000
      end
    end
  end

end
