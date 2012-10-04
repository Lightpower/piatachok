# encoding: utf-8
class SettingsController < ApplicationController

  ##
  # Show settings page
  #
  def index
    authorize! :view, Family

    @user_list = current_user.relatives(false)
    @my_invites = current_user.invites
    @invited_by_family = current_user.family.invites
  end

end
