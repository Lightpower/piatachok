# encoding: UTF-8
module SelectPeriodHelper

  ##
  #  Combobox for period selecting
  #
  def select_period_tag(period_type, period, caption, change_last_date=false)
    return_string = content_tag(:span, caption + " ")
    return_string << select_tag(:select_period, options_from_collection_for_select([["За день", :day], ["За месяц", :month], ["За год", :year], ["Другой период...", :other]], :last, :first, period_type))
    return_string = content_tag(:div, return_string)

    period_string = content_tag(:span, "с ")
    period_string << ("<input type=\"text\" id=\"day\" name=\"day\" class=\"datepicker\" disabled=\"true\" readonly=\"true\" value=\"#{period.first.strftime("%d.%m.%Y")}\">").html_safe
    if change_last_date
      period_string << content_tag(:span, " по ")
      period_string << ("<input type=\"text\" id=\"day2\" name=\"day2\" class=\"datepicker\" disabled=\"true\" readonly=\"true\" value=\"#{period.last.strftime("%d.%m.%Y")}\">").html_safe
    else
      period_string << content_tag(:span, " по сегодня")
    end
    period_string = content_tag(:div, period_string)

    return_string << period_string
    return_string.html_safe
  end
end