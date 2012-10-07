# encoding: utf-8
class FamiliesController < ApplicationController
  load_and_authorize_resource

  ##
  # Update family data
  #
  def update
    if @family.update_attributes(params[:family])
      respond_to do |format|
        format.html { render "settings/index" }
        format.js   { render json: { result: "Данные семьи успешно изменены", status: 200 } }
      end
    else
      respond_to do |format|
        format.html { render "settings/index" }
        format.js   { render json: { result: "Данные семьи не изменены", status: 500 } }
      end
    end

  end
end
