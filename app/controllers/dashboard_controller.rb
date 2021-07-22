class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dashboard

  def index
  end

  def set_dashboard
    @account = Account.where(user_id: current_user.id).with_attached_image
  end
end
