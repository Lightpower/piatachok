class HomeController < ApplicationController

  def index
    redirect_to money_operations_path if current_user.present? && flash[:alert].blank?
  end
end
