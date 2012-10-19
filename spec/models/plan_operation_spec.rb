require 'spec_helper'

describe PlanOperation do
  it "valid" do
    family = FactoryGirl.build(:family)
    family.save!
    user = family.users.last
    object = PlanOperation.new(amount: 1, creator: user)
    object.should be_valid
    object.save.should be_true
  end

  it "failed" do
    object = PlanOperation.new
    object.should_not be_valid
    object.save.should be_false
  end

  it "has correct type" do
    object = PlanOperation.new
    object.type.should == object.class.to_s
  end

end
