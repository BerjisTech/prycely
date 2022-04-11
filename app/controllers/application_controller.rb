# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :json
  respond_to :html

  def after_sign_in_path_for(_resource)
    if session[:invite_key]
      edit_account_path(Account.find_or_create_by(user_id: current_user.id).id)
    else
      dashboard_path
    end
  end

  def after_sign_up_path_for(_resource)
    edit_account_path(Account.find_or_create_by(user_id: current_user.id).id)
  end

  def after_sign_out_path_for(_resource_or_scope)
    reset_session
    request.referrer || root_path
  end

  def has_active_group?
    if session[:current_group].blank? || session[:current_group].empty?
      redirect_to groups_path, notice: 'You need to pick a group before doing that'
    else
      session[:active_group] = session[:current_group]
      @group = Group.find(session[:current_group])
    end
  end

  def set_account
    @account = Account.find_by(user_id: current_user.id)
  end

  def set_group_by_session
    @group = Group.find(session[:current_group])
  end
end
