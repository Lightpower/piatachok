FactoryGirl.define do

  factory :family do
    sequence(:name) { |n| "Family #{n}" }
    head    { FactoryGirl.create(:user) }
  end
end
