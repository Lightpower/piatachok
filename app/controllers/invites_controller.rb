# encoding: utf-8
class InvitesController < ApplicationController

  load_and_authorize_resource     except: [:create, :reject]

  ##
  # Create new invite
  # Method for AJAX callback
  #
  def create
    invite = nil
    # is this invite from user to family
    if params[:invite][:family_name].present?
      authorize! :create, Invite
      new_family = Family.find_by_name(params[:invite][:family_name])
      if new_family.present?
        if current_user.family != new_family
          invite = Invite.new(family: new_family,
                              user: current_user,
                              creator: current_user,
                              is_sent_to_email: false)
        else
          respond_to do |format|
            format.js { render json: { result: "Нельзя попроситься в свою же семью", status: 500 } and return }
          end
        end
      else
        respond_to do |format|
          format.js { render json: { result: "Семья #{params[:invite][:family_name]} не найдена", status: 404 } and return }
        end
      end

    # is this invite from family to user
    elsif params[:invite][:user_data].present?
      authorize! :create, Invite
      # check if this user exists in database
      user = User.find_by_login(params[:invite][:user_data]) || User.find_by_email(params[:invite][:user_data])
      if user.present?
        if current_user != user
          invite = Invite.new(family: current_user.family,
                              user: user,
                              creator: current_user,
                              is_sent_to_email: false)
        else
          respond_to do |format|
            format.js { render json: { result: "Нельзя пригласить самого себя в свою семью", status: 500 } and return }
          end
        end
      else
        if params[:invite][:user_data] =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
          #TODO: send the email with invite to user
          respond_to do |format|
            format.js { render json: {result: "Email с приглашением отправлен на адрес #{params[:invite][:user_data]}", status: 204 } and return }
          end
        else
          respond_to do |format|
            format.js { render json: {result: "Пользователь #{params[:invite][:user_data]} не найден! Вы можете ввести его email и снова пригласить. Мы вышлем ему приглашение на почту.", status: 404 } and return }
          end
        end
      end

    end

    if invite && invite.save!
      respond_to do |format|
        render_string = render_to_string(partial: "invites/invite", layout: false, locals: {name: invite.name_for_family, invite_id: invite.id, can_manage: false})
        format.js { render json: { result: render_string, status: 201 }}
      end
    else
      respond_to do |format|
        format.js { render json: {result: "Не удалось создать приглашение.", status: 500 } }
      end
    end
  end

  ##
  # Accept invite
  # Method for AJAX callback
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
          format.js { render json: {result: "Приглашение принято", status: 200 } }
        end
      else
        respond_to do |format|
          format.js { render json: {result: "Ошибка принятия приглашения", status: 500 } }
        end
      end
    else
      respond_to do |format|
        format.js { render json: {result: "Пользователь не найден", status: 404 } }
      end
    end

  end

  ##
  # Reject invite
  # Method for AJAX callback
  #
  def reject
    @invite = Invite.find_by_id(params[:id])
    if @invite
      authorize! :reject, @invite
      if @invite.delete
        respond_to do |format|
          format.js { render json: {result: "Приглашение отклонено", status: 200 } }
        end
      else
        respond_to do |format|
          format.js { render json: {result: "Ошибка отклонения приглашения", status: 500 } }
        end
      end
    else
      respond_to do |format|
        format.js { render json: {result: "Приглашение не найдено", status: 404 } }
      end
    end
  end

end
