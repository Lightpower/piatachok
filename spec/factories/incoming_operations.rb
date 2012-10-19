FactoryGirl.define do

  factory :incoming_operation, parent: :money_operation do
    amount 10000
  end
end
