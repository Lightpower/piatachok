require 'spec_helper'

describe PlanOperation do
  it "valid" do
    object = PlanOperation.new(amount: 1, creator: FactoryGirl.create(:user))
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
