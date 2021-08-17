# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dashboard

  def index
    # render json: @groups
  end

  def join
    render json: params
  end

  def set_dashboard
    session[:user_id] = current_user.id
    user_id = session[:user_id]

    @account = Account.where(user_id: current_user.id)
    @groups = Group.mine(user_id)
    @invites = Invite.mine(user_id)
  end
end
