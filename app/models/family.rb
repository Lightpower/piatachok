class Family < ActiveRecord::Base
  # associations
  has_many :users
  belongs_to :head, class_name: "User", foreign_key: :head_id

  validates_presence_of :name, :head

  attr_accessible :name, :head

  ##
  # Calculate the balance of current user's family
  #
  def balance
    format("%.2f", connection.execute("select SUM(amount) sum from operations where type='MoneyOperation' and family_id=#{self.id}").first["sum"].to_f / 100.to_f)
  end

  ##
  # Calculate the sum which current user's family is spent today
  #
  def dayly_spent
    format("%.2f", connection.execute("select SUM(amount) sum from operations where type='MoneyOperation' and (created_at between '#{Date.today.beginning_of_day}' and '#{Date.today.end_of_day}') and amount<0 and family_id=#{self.id}").first["sum"].to_f / 100.to_f)
  end

  ##
  # Calculate the sum which current user's family is spent this month
  #
  def monthly_spent
    format("%.2f", connection.execute("select SUM(amount) sum from operations where type='MoneyOperation' and (created_at between '#{Date.today.beginning_of_month}' and '#{Date.today.end_of_day}') and amount<0 and family_id=#{self.id}").first["sum"].to_f / 100.to_f)
  end

  ##
  # Calculate the sum of incomes of current user's family this month
  #
  def monthly_income
    format("%.2f", connection.execute("select SUM(amount) sum from operations where type='MoneyOperation' and (created_at between '#{Date.today.beginning_of_month}' and '#{Date.today.end_of_day}') and amount>0 and family_id=#{self.id}").first["sum"].to_f / 100.to_f)
  end

end
