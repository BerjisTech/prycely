class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    dashboard_path()
  end

  def after_sign_up_path_for(resource)
    account_path(current_user.id)
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer || root_path
  end
end
