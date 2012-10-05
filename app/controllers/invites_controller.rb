# encoding: utf-8
class InvitesController < ApplicationController

  load_and_authorize_resource

  ##
  # Create new invite
  #
  def create
    if @invite.save!
      respond_to do |format|
        format.js { render json: {result: "ok", status: 201 } }
      end
    else
      respond_to do |format|
        format.js { render json: {result: "failed", status: 500 } }
      end
    end
  end

  ##
  # Accept invite
  #
  def accept
    user = User.find_by_id(@invite.user_id).first
    if user.present?
      if user.family.users.size == 1
        user.family.destroy
      end
      user.family_id = @invite.family_id
      if user.save!
        respond_to do |format|
          format.js { render json: {result: "ok", status: 200 } }
        end
      else
        respond_to do |format|
          format.js { render json: {result: "failed", status: 500 } }
        end
      end
    else
      respond_to do |format|
        format.js { render json: {result: "User not found", status: 404 } }
      end
    end

  end

  ##
  # Reject invite
  #
  def reject
    if @invite
      if @invite.delete
        respond_to do |format|
          format.js { render json: {result: "ok", status: 200 } }
        end
      else
        respond_to do |format|
          format.js { render json: {result: "failed", status: 500 } }
        end
      end
      respond_to do |format|
        format.js { render json: {result: "failed", status: 404 } }
      end
    end
  end

end
