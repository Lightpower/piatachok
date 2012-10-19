FactoryGirl.define do

  factory :lend_operation, parent: :credit_operation do
    amount -10000
  end
end
