# encoding: utf-8
class SettingsController < ApplicationController

  ##
  # Show settings page
  #
  def index
    authorize! :view, Family
    @my_invites = { from_me: current_user.invites_from_me,
                    to_me:  current_user.invites_to_me }
    @family_invites = { from_family: current_user.family.invites_from_family,
                        to_family:  current_user.family.invites_to_family }
  end

end
