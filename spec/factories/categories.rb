FactoryGirl.define do

  factory :category do
    sequence(:name)  { |n| "Category #{n}" }
    type "SpendCategory"

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
end
