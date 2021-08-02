class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :json

  def after_sign_in_path_for(resource)
    if session[:invite_key]
      new_account_path()
    else
      dashboard_path()
    end
  end

  def after_sign_up_path_for(resource)
    if session[:invite_key]
      new_account_path()
    else
      account_path(current_user.id)
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    reset_session
    request.referrer || root_path
  end
end
