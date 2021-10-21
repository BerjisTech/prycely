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
end
