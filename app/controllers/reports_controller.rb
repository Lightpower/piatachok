# encoding: utf-8
class ReportsController < ApplicationController

  ##
  # Show list of reports
  #
  def index
  end

  ##
  # Show defined report
  #
  def show

  end

  def single
    @select_period = params[:select_period] || 0
    case @select_period
      when "day"
        @date_from = Date.today
        @date_to = Date.today
      when "month"
        @date_from = Date.today.beginning_of_month
        @date_to = Date.today
      when "year"
        @date_from =Date.today.beginning_of_year
        @date_to = Date.today
      when "other"
        @date_from = params[:day].present?  ? Date.parse(params[:day])  : Date.today
        @date_to =   params[:day2].present? ? Date.parse(params[:day2]) : Date.today
      else
        @date_from = Date.today
        @date_to = Date.today
    end
    @table = Report.single(current_user.family_id, @date_from..@date_to, 1)
    render :show, locals: {report_name: "Простой отчёт", report_type: :single }
  end



end
