credit_operation_spec.rbrequire 'spec_helper'

describe MoneyOperation do
  it "valid" do
    object = MoneyOperation.new(amount: 1, creator: FactoryGirl.create(:user))
    object.should be_valid
    object.save.should be_true
  end

  it "failed" do
    object = MoneyOperation.new
    object.should_not be_valid
    object.save.should be_false
  end

  it "has correct type" do
    object = MoneyOperation.new
    object.type.should == object.class.to_s
  end

end
