require 'spec_helper'

describe SpendCategory do
  it "valid" do
    object = SpendCategory.new(name: "Name")
    object.should be_valid
    object.save.should be_true
  end

  it "failed" do
    object = SpendCategory.new
    object.should_not be_valid
    object.save.should be_false
  end

  it "has correct type" do
    object = SpendCategory.new
    object.type.should == object.class.to_s
  end

end
