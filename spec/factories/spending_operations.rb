FactoryGirl.define do

  factory :spending_operation, parent: :money_operation do
    amount -10000
  end
end
