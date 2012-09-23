module ApplicationHelper

  ##
  #  Show flash messages
  #
  def show_flash
    [:notice, :alert, :error].map { |type|
      content_tag(:div, flash[type], class: type) if flash[type]
    }.join.html_safe
  end

  ##
  # Calculate the balance of current user's family
  #
  def family_balance
    current_user.family.balance
  end

  ##
  # Calculate the sum which current user's family is spent today
  #
  def family_dayly_spent
    current_user.family.dayly_spent
  end

  ##
  # Calculate the sum which current user's family is spent this month
  #
  def family_monthly_spent
    current_user.family.monthly_spent
  end

  ##
  # Calculate the sum of incomes of current user's family this month
  #
  def family_monthly_income
    current_user.family.monthly_income
  end
end
