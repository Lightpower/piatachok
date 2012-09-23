# encoding: UTF-8
module SelectPeriodHelper

  ##
  #  Combobox for period selecting
  #
  def select_period_tag(select_period, day)
    return_string = select_tag(:select_period, options_from_collection_for_select([["День", :day], ["Месяц", :month], ["Год", :year], ["Другой период...", :other]], :last, :first, select_period))
    return_string << ("<input type=\"text\" id=\"day\" name=\"day\" class=\"datepicker\" disabled=\"true\" readonly=\"true\" value=\"#{day.strftime("%d.%m.%Y")}\">").html_safe
    return_string.html_safe
  end
end