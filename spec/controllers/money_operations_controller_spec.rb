require 'spec_helper'

describe MoneyOperationsController do

  context "unauthorized user" do

    it "redirects to home" do
      get :index

      response.should redirect_to(root_url)
    end
  end

  context "unauthorized user" do
    before :each do
      authenticate_user
    end


    it "redirects to money_operations" do
      get :index

      request.params.should_not be_blank
      request.params["money_operation"][:is_spent].should be_true
    end
  end
end