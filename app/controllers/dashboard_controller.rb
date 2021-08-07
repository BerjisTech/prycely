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
    @account = Account.where(user_id: current_user.id)
    @groups = Member.where.not(status: '0').where(user_id: current_user.id).joins(:group).select(:id, :name,
                                                                                                 :membership, :created_by, :group_id, :currency, :group_type)
    @invites = Member.where(status: '0').where(user_id: current_user.id).joins(:group).select(:id, :name, :membership,
                                                                                              :created_by, :currency, :group_type, :group_id)
  end
end
