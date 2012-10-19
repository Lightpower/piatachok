FactoryGirl.define do

  factory :operation do
    creator { FactoryGirl.create(:user) }
    user
    family  { FactoryGirl.create(:family) }
    type "MoneyOperation"
    amount 0

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
