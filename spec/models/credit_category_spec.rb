require 'spec_helper'

describe CreditCategory do
  it "valid" do
    object = CreditCategory.new(name: "Name")
    object.should be_valid
    object.save.should be_true
  end

  it "failed" do
    object = CreditCategory.new
    object.should_not be_valid
    object.save.should be_false
  end

  it "has correct type" do
    object = CreditCategory.new
    object.type.should == object.class.to_s
  end

end
