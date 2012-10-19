FactoryGirl.define do

  factory :operation do
    creator { FactoryGirl.create(:user) }
    user
    family  { FactoryGirl.create(:family) }
    type "MoneyOperation"
    amount 1
  end

end
