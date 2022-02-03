# frozen_string_literal: true

class NcbaController < ApplicationController
  NO_PARAMS_ERROR = { error: 'Kindly pass all required parameters' }.freeze

  def account_opening
    render json: NO_PARAMS_ERROR
  end

  def credit_details
    render json: NO_PARAMS_ERROR
  end

  def credit_transfer
    render json: NO_PARAMS_ERROR
  end

  def mpesa_verification
    render json: NO_PARAMS_ERROR
  end

  def push_notif
    Ncba.hash_value(
      params[:secret],
      params[:trans_type],
      params[:trans_id],
      params[:trans_time],
      params[:trans_amount],
      params[:account_number],
      params[:narrative],
      params[:phone_number],
      params[:customer_name],
      params[:status]
    )
    
    render json: NO_PARAMS_ERROR
  end

  def transaction_query; end

  def call; end
end
