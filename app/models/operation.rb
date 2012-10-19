class Operation < ActiveRecord::Base

  belongs_to :user
  belongs_to :creator, class_name: "User", foreign_key: :created_by
  belongs_to :category
  belongs_to :family

  validates_presence_of :amount, :type, :creator

  before_create :add_family_id, if: Proc.new { self.family_id.blank? }

  attr_accessible :amount, :category_id, :user_id, :created_by, :creator, :comment, :family_id

  TYPES = %w{MoneyOperation CreditOperation PlanOperation}

  private

  ##
  # before_filter for adding family_id to new operation
  #
  def add_family_id
    self.family_id = self.user.family_id unless self.family_id
  end
end
