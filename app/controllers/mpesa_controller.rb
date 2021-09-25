# frozen_string_literal: true

class MpesaController < ApplicationController
  before_action :authenticate_user!, only: %i[stk b2c check_paybill_transaction]
  skip_before_action :verify_authenticity_token, only: %i[c2b callback_stk callback_b2c callback_c2b]
  before_action :set_mpesa

  def index; end

  def b2c
    amount = 10
    phone = 254_725_227_513
    command_id = 'BusinessPayment'
    remarks = "Withdrawal for #{phone} on #{DateTime.now}"

    path = '/mpesa/b2c/v1/paymentrequest'

    body = {
      'InitiatorName': @B2C_USERNAME,
      'SecurityCredential': @MPESA_B2C_API_PASSKEY,
      'CommandID': command_id,
      'Amount': amount,
      'PartyA': @B2C_PAYBILL,
      'PartyB': phone,
      'Remarks': remarks,
      'QueueTimeOutURL': @TIMEOUT_URL,
      'ResultURL': @RESULT_URL,
      'Occasion': '' # optional
    }
    render json: call(path, body, @MPESA_B2C_API_KEY, @MPESA_B2C_API_SECRET)
  end

  def c2b
    message = 'Ok'
    Error.add_error('c2b', params, request.referer, message)
    Paybill.process_paybill_response(params)
  end

  def stk
    @amount = params[:amount].to_f
    @phone = params[:phone]
    @ref = params[:reference]
    @desc = params[:description]
    @origin = params[:origin]
    @recepient = params[:recepient]

    if @amount.present? && @amount != '' && @phone.present? && @phone != '' && @ref.present? && @ref != '' && @desc.present? && @desc != '' && @origin.present? && @origin != '' && @recepient.present? && @recepient != ''
      level = Transact.level_to_int(params[:level])
      account = params[:account]
      amount = Concurrency.convert(@amount, @origin, @recepient)
      amount = amount.round(0) + 1

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
        'PartyA': @phone,
        'PartyB': shortcode,
        'PhoneNumber': @phone,
        'CallBackURL': @STK_CALLBACK,
        'AccountReference': @ref,
        'TransactionDesc': @desc
      }

      response = call(path, body, @MPESA_API_KEY, @MPESA_API_SECRET)

      status = 0 if response.present?

      message = 'OK'
      Error.add_error('stk', response.body, request.referer, message)

      response = JSON.parse(response.body)

      Stk.create_stk(response, "+#{@phone}", status)
      Transaction.create_from_stk(amount, response, current_user.id, @desc, level, account, @origin)

      user_response = { type: 'Ok', title: 'Success',
                        message: "A #{@recepient} #{amount} transaction has been sent to #{@phone}" }
    else
      user_response = { type: 'Error', title: 'Missing data',
                        message: 'Some required information is missing' }
    end

    render json: user_response
  end

  def paybill; end

  def check_paybill_transaction
    mpesaReceiptNumber = params[:mpesa_code]
    level = Transact.level_to_int(params[:level])
    account = params[:account]

    current_transaction = Transaction.find_by(transaction_reference: mpesaReceiptNumber, group_id: nil, wallet_id: nil)
    update_data = { level: level, wallet_id: account, group_id: account, status: 1, user_id: current_user.id }

    if level.present? && account.present? && mpesaReceiptNumber.present?
      if current_transaction.present?
        current_transaction.update_all(update_data)
        { title: 'Success', message: 'Transaction confirmed', type: 'Info' }
      else
        { title: 'Oops', message: 'There\'s no transaction with this code. Check the MPesa code and try again',
          type: 'Info' }
      end
    else
      { title: '', message: 'Something went wrong, kindly contact support', type: 'Info' }
    end
  end

  def callback_b2c
    message = 'Ok'
    Error.add_error('c2b', params, request.referer, message)
    Paybill.process_paybill_response(params)
  end

  def callback_c2b; end

  def callback_stk
    if params.present?
      if params['Body'].present?
        error = params['Body']
        message = 'OK'
        Error.add_error('stk_callback', error, request.referer, message)
        Stk.update_stk(params['Body']['stkCallback'])
      else
        message = 'Body not passed or processed'
        Error.add_error('stk_callback', params, request.referer, message)
      end
    end
  end

  def register_url
    path = '/mpesa/c2b/v1/registerurl'
    body = {
      'ShortCode': @C2B_PAYBILL,
      'ResponseType': 'Completed',
      'ConfirmationURL': @CONFIRMATION_URL,
      'ValidationURL': @VALIDATION_URL
    }

    call(path, body, @MPESA_API_KEY, @MPESA_API_SECRET)
  end

  def validation; end

  def access_token(key, secret)
    path = '/oauth/v1/generate?grant_type=client_credentials'
    base_url = @BASE_URL
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

  def call(path, body, key, secret)
    base_url = @BASE_URL
    res = access_token(key, secret)
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
    @MPESA_API_KEY = Siri.find_by(name: 'MPESA_API_KEY').value
    @MPESA_API_SECRET = Siri.find_by(name: 'MPESA_API_SECRET').value
    @MPESA_API_PASSKEY = Siri.find_by(name: 'MPESA_API_PASSKEY').value

    @MPESA_SANDBOX_API_KEY = Siri.find_by(name: 'MPESA_SANDBOX_API_KEY').value
    @MPESA_SANDBOX_API_SECRET = Siri.find_by(name: 'MPESA_SANDBOX_API_SECRET').value
    @MPESA_SANDBOX_API_PASSKEY = Siri.find_by(name: 'MPESA_SANDBOX_API_PASSKEY').value

    @MPESA_B2C_API_KEY = Siri.find_by(name: 'MPESA_B2C_API_KEY').value
    @MPESA_B2C_API_SECRET = Siri.find_by(name: 'MPESA_B2C_API_SECRET').value
    @MPESA_B2C_API_PASSKEY = Siri.find_by(name: 'MPESA_B2C_API_PASSKEY').value

    @C2B_PAYBILL = Siri.find_by(name: 'C2B_PAYBILL').value
    @B2C_PAYBILL = Siri.find_by(name: 'B2C_PAYBILL').value
    @C2B_USERNAME = Siri.find_by(name: 'C2B_USERNAME').value
    @B2C_USERNAME = Siri.find_by(name: 'B2C_USERNAME').value

    @BASE_URL = Siri.find_by(name: 'BASE_URL').value
    @TIMEOUT_URL = Siri.find_by(name: 'TIMEOUT_URL').value
    @RESULT_URL = Siri.find_by(name: 'RESULT_URL').value
    @CONFIRMATION_URL = Siri.find_by(name: 'CONFIRMATION_URL').value
    @VALIDATION_URL = Siri.find_by(name: 'VALIDATION_URL').value

    @STK_CALLBACK = Siri.find_by(name: 'STK_CALLBACK').value
  end
end
