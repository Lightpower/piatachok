require 'spec_helper'

describe IncomeCategory do
  it "valid" do
    object = IncomeCategory.new(name: "Name")
    object.should be_valid
    object.save.should be_true
  end

  it "failed" do
    object = IncomeCategory.new
    object.should_not be_valid
    object.save.should be_false
  end

  it "has correct type" do
    object = IncomeCategory.new
    object.type.should == object.class.to_s
  end

end
