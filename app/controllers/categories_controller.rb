# encoding: utf-8
class CategoriesController < ApplicationController

  load_and_authorize_resource except: [:index]

  ##
  # Show list of user's categories
  #
  def index
    authorize! :view, Family
    @spend_categories = SpendCategory.where(family_id: current_user.family.id)
    @spend_categories.order("name DESC") if @spend_categories.present?
    @income_categories = IncomeCategory.where(family_id: current_user.family.id)
    @income_categories.order("name DESC") if @income_categories.present?
  end

  ##
  # Create new user's category
  #
  def create
    @category.family = current_user.family
    authorize! :create, @category
    if @category.save!
      flash[:notice] = "Категория успешно добавлена"
    else
      flash[:alert] = "Ошибка добавления категории трат: #{@category.errors.full_messages}"
    end

    respond_to do |format|
      format.html { redirect_to categories_path }
    end
  end

  ##
  # Create new user's category
  #
  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = "Категория успешно изменена"
    else
      flash[:alert] = "Ошибка изменения категории: #{@category.errors.full_messages}"
    end
    respond_to do |format|
      format.html { redirect_to categories_path }
    end
  end

  ##
  # Delete user's category
  #
  def destroy
    if @category.delete
      flash[:notice] = "Категория успешно удалена"
    else
      flash[:alert] = "Ошибка удаления категории: #{@category.errors.full_messages}"
    end

    respond_to do |format|
      format.html { redirect_to categories_path }
    end
  end

end
