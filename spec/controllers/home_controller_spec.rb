require 'spec_helper'

describe HomeController do

  context "unauthorized user" do

    it "redirects to money_operations" do
      get :index
      response.should_not redirect_to(money_operations_path)
    end
  end

  context "authorized user" do
    before :each do
      authenticate_user
    end


    it "redirects to money_operations" do
      get :index
      response.should redirect_to(money_operations_path)
    end
  end
end