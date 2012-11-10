# encoding: utf-8
class CategoriesController < ApplicationController

  load_and_authorize_resource except: [:create, :reject]

  ##
  # Create new user's category
  # Method for AJAX callback
  #
  def create

  end

end
