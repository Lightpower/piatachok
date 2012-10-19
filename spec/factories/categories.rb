FactoryGirl.define do

  factory :category do
    sequence(:name)  { |n| "Category #{n}" }
    type "SpendCategory"
  end
end
