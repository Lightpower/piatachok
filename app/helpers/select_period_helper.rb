# encoding: UTF-8
module SelectPeriodHelper

  ##
  #  Combobox for period selecting
  #
  def select_period_tag(select_period, day, caption)
    return_string = content_tag(:span, caption + " ")
    return_string << select_tag(:select_period, options_from_collection_for_select([["День", :day], ["Месяц", :month], ["Год", :year], ["Другой период...", :other]], :last, :first, select_period))
    return_string = content_tag(:div, return_string)

    period_string = content_tag(:span, "с ")
    period_string << ("<input type=\"text\" id=\"day\" name=\"day\" class=\"datepicker\" disabled=\"true\" readonly=\"true\" value=\"#{day.strftime("%d.%m.%Y")}\">").html_safe
    period_string << content_tag(:span, " по ")
    period_string << ("<input type=\"text\" id=\"today\" name=\"today\" class=\"datepicker\" disabled=\"true\" readonly=\"true\" value=\"#{day.strftime("%d.%m.%Y")}\">").html_safe
    period_string = content_tag(:div, period_string)

    return_string << period_string
    return_string.html_safe
  end
end