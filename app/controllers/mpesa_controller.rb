# frozen_string_literal: true

class MpesaController < ApplicationController
  # require 'faraday'
  # require "faraday_middleware"
  skip_before_action :verify_authenticity_token, only: %i[callback_stk callback_b2c callback_c2b]
  before_action :set_mpesa

  def index; end

  def b2c
    amount = 0
    phone = 254_725_227_513
    command_id = ''
    remarks = ''

    path = '/mpesa/b2c/v1/paymentrequest'

    body = {
      'InitiatorName': @B2C_USERNAME,
      'SecurityCredential': @MPESA_API_PASSKEY,
      'CommandID': command_id,
      'Amount': amount,
      'PartyA': @C2B_PAYBILL,
      'PartyB': phone,
      'Remarks': remarks,
      'QueueTimeOutURL': @TIMEOUT_URL,
      'ResultURL': @RESULT_URL,
      'Occasion': '' # optional
    }
    call(path, body)
  end

  def c2b
    path = '/mpesa/c2b/v1/registerurl'
    body = {
      'ShortCode': @C2B_PAYBILL,
      'ResponseType': 'Completed',
      'ConfirmationURL': @CONFIRMATION_URL,
      'ValidationURL': @VALIDATION_URL
    }

    call(path, body)
  end

  def stk
    amount = 10
    phone = 254_725_227_513
    ref = 'Payment'
    desc = 'Payment'

    shortcode = @C2B_PAYBILL
    lipa_na_mpesa_key = @MPESA_API_PASSKEY
    timestamp = Time.now.strftime('%Y%m%d%H%M%S').to_i
    password = Base64.encode64("#{shortcode}#{lipa_na_mpesa_key}#{timestamp}")
    path = '/mpesa/stkpush/v1/processrequest'
    body = {
      'BusinessShortCode': shortcode,
      'Password': password.split("\n").join,
      'Timestamp': timestamp.to_s,
      'TransactionType': 'CustomerPayBillOnline',
      'Amount': amount,
      'PartyA': phone,
      'PartyB': shortcode,
      'PhoneNumber': phone,
      'CallBackURL': @STK_CALLBACK,
      'AccountReference': ref,
      'TransactionDesc': desc
    }

    call(path, body)
  end

  def paybill; end

  def callback_b2c; end

  def callback_c2b; end

  def callback_stk; end

  def register_url
    path = '/mpesa/c2b/v1/registerurl'
    body = {
      'ShortCode': @C2B_PAYBILL,
      'ResponseType': 'Completed',
      'ConfirmationURL': @CONFIRMATION_URL,
      'ValidationURL': @VALIDATION_URL
    }

    call(path, body)
  end

  def validation; end

  def access_token
    path = '/oauth/v1/generate?grant_type=client_credentials'
    base_url = @BASE_URL
    key = @MPESA_API_KEY
    secret = @MPESA_API_SECRET
    conn = Faraday.new(url: base_url + path) do |req|
      req.adapter Faraday.default_adapter
      req.basic_auth(key, secret)
    end
    conn.get

    # request = conn.get
    # render json: JSON.parse(request.body)["access_token"]
  end

  def b2c_token; end

  def phone_format; end

  def phone_format_b2c; end

  def update_wallet; end

  def mpesa_params
    params.require(:mpesa).permit(:phone, :amount)
  end

  private

  def call(path, body)
    base_url = @BASE_URL
    res = access_token
    return res unless res.status == 200

    token = JSON.parse(res.body)['access_token']
    headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': "Bearer #{token}"
    }
    Faraday.post(base_url + path, body.to_json, headers)
  end

  def set_mpesa
    @MPESA_API_KEY = ENV.fetch('MPESA_API_KEY')
    @MPESA_API_SECRET = ENV.fetch('MPESA_API_SECRET')
    @MPESA_API_PASSKEY = ENV.fetch('MPESA_API_PASSKEY')

    @MPESA_SANDBOX_API_KEY = ENV.fetch('MPESA_SANDBOX_API_KEY')
    @MPESA_SANDBOX_API_SECRET = ENV.fetch('MPESA_SANDBOX_API_SECRET')
    @MPESA_SANDBOX_API_PASSKEY = ENV.fetch('MPESA_SANDBOX_API_PASSKEY')

    @MPESA_B2C_API_KEY = ENV.fetch('MPESA_B2C_API_KEY')
    @MPESA_B2C_API_SECRET = ENV.fetch('MPESA_B2C_API_SECRET')
    @MPESA_B2C_API_PASSKEY = ENV.fetch('MPESA_B2C_API_PASSKEY')

    @C2B_PAYBILL = ENV.fetch('C2B_PAYBILL')
    @B2C_PAYBILL = ENV.fetch('B2C_PAYBILL')
    @C2B_USERNAME = ENV.fetch('C2B_USERNAME')
    @B2C_USERNAME = ENV.fetch('B2C_USERNAME')

    @BASE_URL = ENV.fetch('BASE_URL')
    @TIMEOUT_URL = ENV.fetch('TIMEOUT_URL')
    @RESULT_URL = ENV.fetch('RESULT_URL')
    @CONFIRMATION_URL = ENV.fetch('CONFIRMATION_URL')
    @VALIDATION_URL = ENV.fetch('VALIDATION_URL')

    @STK_CALLBACK = ENV.fetch('STK_CALLBACK')
  end
end
