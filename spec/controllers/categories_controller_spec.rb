# encoding: UTF-8
require 'spec_helper'

describe CategoriesController do

  describe "unauthorized user" do

    it "redirects to new spending" do
      get :index

      response.should redirect_to(root_url)
    end
  end

  describe "authorized user" do
    before :each do
      authenticate_user
    end


    context "GET :index" do
      render_views

      it "render :index" do
        get :index

        response.status.should == 200
        response.body.include?("<h2>Категории трат</h2>").should be_true
      end
    end

    context "POST :create" do

      it "creates new category" do
        params = { category: {name: "Test 1", type: SpendCategory} }
        post :create, params

        response.status.should == 302

        category = SpendCategory.last
        category.name.should == params[:category][:name]
        category.family.should == @user.family
      end
    end

    context "PUT :update" do

      it "updates existing category" do
        old_category = FactoryGirl.create(:spend_category, name: "Category 1", family: @user.family)

        params = { category: {name: "Test 1", type: SpendCategory}, id: old_category.id }

        put :update, params

        response.status.should == 302

        category = SpendCategory.last
        category.name.should == params[:category][:name]
      end
    end


    context "PUT :delete" do

      it "destroys operation" do
        FactoryGirl.create(:spend_category, name: "Category 1", family: @user.family)
        category_id = SpendCategory.last.id

        delete :destroy, id: category_id

        response.status.should == 302

        SpendCategory.find_by_id(category_id).should be_nil
      end
    end
  end

end