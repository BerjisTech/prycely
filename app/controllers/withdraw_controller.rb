# frozen_string_literal: true

class WithdrawController < ApplicationController
  before_action :has_active_group?
  before_action :check_if_manager
  
  def mpesa; end

  def bank; end

  def paypal; end
end
