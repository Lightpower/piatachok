# encoding: UTF-8
require 'spec_helper'

describe MoneyOperationsController do

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

      it "renders :new" do
        get :index

        response.status.should == 200
        request.params["money_operation"][:is_spent].should be_true
        response.body.include?("<h1>Новая трата</h1>").should be_true
        response.body.include?("<h1>Список операций</h1>").should be_false
      end

      it "render :index" do
        params = { "operation_type"=>{"spend"=>"true"} }
        get :index, params

        request.params.should_not be_blank
        request.params["operation_type"][:spend].should be_true

        response.body.include?("<h1>Новая трата</h1>").should be_false
        response.body.include?("<h1>Список операций</h1>").should be_true
      end

      it "render :index" do
        params = { "operation_type"=>{"spend"=>"true", "income" => "true"} }
        get :index, params

        request.params.should_not be_blank
        request.params["operation_type"][:spend].should be_true
        request.params["operation_type"][:income].should be_true

        response.body.include?("<h1>Новая трата</h1>").should be_false
        response.body.include?("<h1>Список операций</h1>").should be_true
      end
    end

    context "GET :show" do
      render_views

      it "shows spending" do
        FactoryGirl.create(:spending_operation, creator: @user, user: @user)
        money_operation = MoneyOperation.last

        get :show, id: money_operation.id

        response.status.should == 200
        response.body.should have_content("Данные о трате")
        response.body.should have_content("Дата: #{money_operation.created_at.strftime("%d.%m.%Y %H:%M")}")
        response.body.should have_content("Сумма: #{money_operation.amount_formatted}")
        response.body.should have_content("Категория: #{money_operation.category.try(:name)}")
        response.body.should have_content("Кто потратил: #{money_operation.user.try(:show_name)}")
        response.body.should have_content("Кто записал: #{money_operation.creator.show_name}")
        response.body.include?("<b>Комментарий: </b>#{money_operation.comment}").should be_true
      end

      it "shows incoming" do
        FactoryGirl.create(:incoming_operation, creator: @user, user: @user)
        money_operation = MoneyOperation.last

        get :show, id: money_operation.id

        response.status.should == 200
        response.body.should have_content("Данные о поступлении")
        response.body.should have_content("Дата: #{money_operation.created_at.strftime("%d.%m.%Y %H:%M")}")
        response.body.should have_content("Сумма: #{money_operation.amount_formatted}")
        response.body.should have_content("Категория: #{money_operation.category.try(:name)}")
        response.body.should have_content("Кто внёс: #{money_operation.user.try(:show_name)}")
        response.body.should have_content("Кто записал: #{money_operation.creator.show_name}")
        response.body.include?("<b>Комментарий: </b>#{money_operation.comment}").should be_true

      end

    end

    context "GET :new" do
      render_views

      it "opens new spending form" do

        get :new, money_operation: {is_spent: true}

        response.status.should == 200
        response.body.should have_content("Новая трата")
      end

      it "opens new incoming form" do

        get :new, money_operation: {is_spent: false}

        response.status.should == 200
        response.body.should have_content("Новое поступление")
      end

    end

    context "GET :edit" do
      render_views

      it "opens spending form for editing" do
        FactoryGirl.create(:spending_operation, creator: @user, user: @user)
        money_operation = MoneyOperation.last

        get :edit, id: money_operation

        response.status.should == 200
        response.body.should have_content("Правка траты")
      end

      it "opens incoming form for editing" do
        FactoryGirl.create(:incoming_operation, creator: @user, user: @user)
        money_operation = MoneyOperation.last

        get :edit, id: money_operation

        response.status.should == 200
        response.body.should have_content("Правка поступления")
      end

    end

    context "POST :create" do

      it "creates new spending" do
        FactoryGirl.create(:spend_category, name: "Category 1")
        category = SpendCategory.last
        params = { operation_type: "spend",
                   money_operation: {"amount_formatted"=>"101010", "category_id"=>category.id.to_s,
                                     "user_id"=>@user.id.to_s, "comment"=>"qwe"}
                 }
        post :create, params

        response.status.should == 302
        spending = MoneyOperation.last
        spending.amount.should == -10101000
        spending.category.should == category
        spending.user.should == @user
        spending.creator.should == @user
        spending.comment.should == "qwe"
      end

      it "creates new incoming" do
        FactoryGirl.create(:income_category, name: "Category 1")
        category = IncomeCategory.last
        params = { operation_type: "income",
                   money_operation: {"amount_formatted"=>"101010", "category_id"=>category.id.to_s,
                                     "user_id"=>@user.id.to_s, "comment"=>"qwe"}
        }
        post :create, params

        response.status.should == 302
        spending = MoneyOperation.last
        spending.amount.should == 10101000
        spending.category.should == category
        spending.user.should == @user
        spending.creator.should == @user
        spending.comment.should == "qwe"
      end

    end

    context "PUT :update" do

      it "updates existing spending" do
        FactoryGirl.create(:spend_category, name: "Category 1")
        FactoryGirl.create(:spend_category, name: "Category 2")
        old_spending = FactoryGirl.create(:spending_operation, user: @user, creator: @user, category: SpendCategory.first)
        new_category = SpendCategory.last


        params = { operation_type: "spend", id: old_spending.id,
                   money_operation: {"amount_formatted"=>"101010", "category_id"=>new_category.id.to_s,
                                     "user_id"=>@user.id.to_s, "comment"=>"qwe"}
        }
        put :update, params

        response.status.should == 302
        operation = MoneyOperation.last
        operation.amount.should == -10101000
        operation.category.should == new_category
        operation.user.should == @user
        operation.creator.should == @user
        operation.comment.should == "qwe"
      end

      it "updates existing incoming" do
        FactoryGirl.create(:income_category, name: "Category 1")
        FactoryGirl.create(:income_category, name: "Category 2")
        old_incoming = FactoryGirl.create(:incoming_operation, user: @user, creator: @user, category: IncomeCategory.first)
        new_category = IncomeCategory.last
        params = { operation_type: "income", id: old_incoming.id,
                   money_operation: {"amount_formatted"=>"101010", "category_id"=>new_category.id.to_s,
                                     "user_id"=>@user.id.to_s, "comment"=>"qwe"}
        }
        put :update, params

        response.status.should == 302
        operation = MoneyOperation.last
        operation.amount.should == 10101000
        operation.category.should == new_category
        operation.user.should == @user
        operation.creator.should == @user
        operation.comment.should == "qwe"
      end

    end


    context "PUT :delete" do

      it "destroys operation" do
        render_views

        it "shows spending" do
          FactoryGirl.create(:spending_operation, creator: @user, user: @user)
          money_operation_id = MoneyOperation.last.id

          put :delete, id: money_operation_id

          response.status.should == 200
          MoneyOperation.find_by_id(money_operation_id).should be_nil
        end

      end
    end
  end

end