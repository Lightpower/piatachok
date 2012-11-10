require 'spec_helper'

describe HomeController do

  context "unauthorized user" do
    render_views

    it "redirects to money_operations" do
      get :index
      response.status.should == 200
      response.body.include?("home / index").should be_true
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