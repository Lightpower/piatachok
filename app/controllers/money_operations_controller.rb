# encoding: utf-8
class MoneyOperationsController < ApplicationController
  load_and_authorize_resource  except: [:index, :new]

  ##
  # List of Spends or Incomes
  #
  def index
    if params[:operation_type].present?
      @operation_type = {}
      @operation_type[:spend] = params[:operation_type][:spend]
      @operation_type[:income] = params[:operation_type][:income]
      @select_period = params[:select_period]
      @date_from = case @select_period
        when "day"
          Date.today
        when "month"
          Date.today.beginning_of_month
        when "year"
          Date.today.beginning_of_year
        when "other"
          params[:day].present? ? Date.parse(params[:day]) : Date.today
        else
          Date.today
        end
      @date_to = Date.today
      @operations = MoneyOperation.index(params[:operation_type], @date_from.beginning_of_day, @date_to.end_of_day, current_user.family_id)
    else
      params[:money_operation] = {is_spent: "true"}
      load_data_for_operation_form
      @short_form = true

      render :new
    end
  end

  def show
    @money_operation.is_spent = @money_operation.amount <= 0

  end

  def new
    load_data_for_operation_form
    @short_form = false
  end

  def edit
    load_data_for_operation_form
    @short_form = false
  end

  def create
    @money_operation.created_by = current_user.id
    @money_operation.family_id = current_user.family_id
    @money_operation.amount = (params[:money_operation][:amount_formatted].sub(",", ".").to_f * 100).to_i
    @money_operation.amount *= -1 if params[:operation_type] == "spend"

    if @money_operation.save

      redirect_to money_operation_path(@money_operation)
    else
      redirect_to edit_money_operation_path(@money_operation)
    end
  end

  def update
    @money_operation.amount = (params[:money_operation][:amount_formatted].sub(",", ".").to_f * 100).to_i
    @money_operation.amount *= -1 if params[:operation_type] == "spend"

    if @money_operation.save
      redirect_to money_operation_path(@money_operation)
    else
      redirect_to edit_money_operation_path(@money_operation)
    end
  end

  def destroy
    if @money_operation.delete
      respond_to do |format|
        format.html { redirect_to money_operations_path(operation_type: {spend: true, income: true})}
        format.js { render json: {result: "ok", status: 200 } }
      end
    else
      respond_to do |format|
        format.html { redirect_to money_operation_path(@money_operation)}
        format.js { render json: {result: "error", status: 500 } }
      end
    end
  end

  private

  # Loads data for dropdown boxes
  # It should be called after load_and_authorize_resource
  #
  def load_data_for_operation_form
    @money_operation = MoneyOperation.new if @money_operation.blank?
    if @money_operation.amount.present?
      @money_operation.is_spent = @money_operation.amount < 0
    elsif params[:money_operation].present? && params[:money_operation][:is_spent].present?
      @money_operation.is_spent = params[:money_operation][:is_spent] == "true"
    end

    @money_operation.user_id = current_user.id
    @money_categories = @money_operation.is_spent ?
        SpendCategory.all.map { |mc| [mc.name, mc.id] } : IncomeCategory.all.map { |mc| [mc.name, mc.id] }
    @users_relatives = current_user.relatives(true).map {|u| [u.show_name, u.id]}
  end
end
