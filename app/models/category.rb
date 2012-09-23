# encoding: UTF-8
class Category < ActiveRecord::Base

  validates_presence_of :name, :type

  validate :correct_type

  attr_accessible :name

  ##
  # Classes for categories:
  #
  #   {SpendCategory}  - categories for spendings (e.g. "Food", "Transport", etc.)
  #   {IncomeCategory} - categories for incomings (e.g. "Salary", "Gift", etc.)
  #   {CreditCategory} - categories for lending or taking on credit
  #   {PlanCategories} - categories for planning the spending or incoming
  #
  TYPES = %w{SpendCategory IncomeCategory CreditCategory PlanCategory}


  private

  ##
  # Validation of type
  #
  def correct_type
    Category::TYPES.include? self.type
  end
end
