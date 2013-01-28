# encoding: UTF-8

class MoneyOperation < Operation

  attr_accessor :is_spent, :amount_formatted
  attr_accessible :amount_formatted

  class << self

    def of_family(family_id)
      where(family_id: family_id)
    end

    ##
    # List of spending by period
    #
    def spends
      where("amount <= 0")
    end

    ##
    # List of incoming by period
    #
    def incomes
      where("amount > 0")
    end

    ##
    # List of operations by period
    #
    def by_period(period=Date.today.beginning_of_day..Date.today.end_of_day)
      where(created_at: period)
    end

    ##
    # Ordering by period
    #
    def order_by_period
      order("created_at DESC")
    end

    ##
    # Getting list of ID, NAME and TYPE of categories which was used by family
    #
    def categories_of_family(family_id)
      MoneyOperation.where(family_id: family_id)
      .joins("INNER JOIN categories ON(operations.category_id = categories.id)")
      .order("categories.type desc, categories.id")
      .select("categories.id, categories.name, categories.type").uniq
    end
  end

  ##
  # Form list of incoming or spending
  #
  # operation_type {String}   - "spend" and/or "income"
  # date_from      {DateTime} - beginning of period
  # date_to        {DateTime} - end of period
  #
  def self.index(operation_type, date_from, date_to, family_id)
    operations = MoneyOperation.of_family(family_id).by_period(date_from..date_to).order_by_period
    if operation_type[:spend] && operation_type[:income]
      # show both of spends and incomes - no condition
    elsif operation_type[:spend]
      operations = operations.spends
    elsif operation_type[:income]
      operations = operations.incomes
    else
      operations = []
    end
    operations.order("created_at DESC") unless operations.blank?
  end

  ##
  # Define if current operation is Spending
  #
  def spending?
    self.amount < 0 || ((self.amount == 0) && (SpendCategory.all.include?(self.category)))
  end

  ##
  # Define if current operation is Incoming
  #
  def incoming?
    self.amount >= 0  || ((self.amount == 0) && (IncomeCategory.all.include?(self.category)))
  end

  ##
  # Return string of unsigned amount with 2 digits after decimal delimiter
  #
  def amount_formatted
    self.amount.present? ? format("%.2f", self.amount.abs.to_f / 100.to_f) : ""
  end

  ##
  # Return string of signed amount with 2 digits after decimal delimiter
  #
  def self.sum_formatted(sum)
    sum.present? ? format("%.2f", sum.abs.to_f / 100.to_f) : "0"
  end

end
