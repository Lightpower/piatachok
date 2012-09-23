require 'spec_helper'

describe PlanCategory do
  it "valid" do
    object = PlanCategory.new(name: "Name")
    object.should be_valid
    object.save.should be_true
  end

  it "failed" do
    object = PlanCategory.new
    object.should_not be_valid
    object.save.should be_false
  end

  it "has correct type" do
    object = PlanCategory.new
    object.type.should == object.class.to_s
  end

end
