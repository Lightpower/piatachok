require 'spec_helper'

describe CreditOperation do
  it "valid" do
    family = FactoryGirl.create(:family)
    user = family.users.last
    object = CreditOperation.new(amount: 1, creator: user)
    object.should be_valid
    object.save.should be_true
  end

  it "failed" do
    object = CreditOperation.new
    object.should_not be_valid
    object.save.should be_false
  end

  it "has correct type" do
    object = CreditOperation.new
    object.type.should == object.class.to_s
  end

end
