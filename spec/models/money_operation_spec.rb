require 'spec_helper'

describe MoneyOperation do
  it "valid" do
    user = FactoryGirl.create(:user)
    family = FactoryGirl.create(:family, head: user)
    user.family = family
    user.save!
    user.reload

    object = MoneyOperation.new(amount: 1, user: user, creator: user)
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
