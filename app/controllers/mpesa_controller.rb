class MpesaController < ApplicationController
  # require 'faraday'
  # require "faraday_middleware"
  before_action :set_mpesa

  def index
  end

  def b2c
    amount = 0
    phone = 254725227513
    command_id = ""
    remarks = ""

    path = "/mpesa/b2c/v1/paymentrequest"

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
      'Occasion': "", # optional
    }
    call(path, body)
  end

  def c2b
    path = "/mpesa/c2b/v1/registerurl"
    body = {
      'ShortCode': @C2B_PAYBILL,
      'ResponseType': "Completed",
      'ConfirmationURL': @CONFIRMATION_URL,
      'ValidationURL': @VALIDATION_URL,
    }

    call(path, body)
  end

  def stk
    amount = 10
    phone = 254725227513
    ref = "Payment"
    desc = "Payment"

    shortcode = @C2B_PAYBILL
    lipa_na_mpesa_key = @MPESA_API_PASSKEY
    timestamp = Time.now.strftime("%Y%m%d%H%M%S").to_i
    password = Base64.encode64("#{shortcode}#{lipa_na_mpesa_key}#{timestamp}")
    path = "/mpesa/stkpush/v1/processrequest"
    body = {
      'BusinessShortCode': shortcode,
      'Password': password.split("\n").join,
      'Timestamp': timestamp.to_s,
      'TransactionType': "CustomerPayBillOnline",
      'Amount': amount,
      'PartyA': phone,
      'PartyB': shortcode,
      'PhoneNumber': phone,
      'CallBackURL': @STK_CALLBACK,
      'AccountReference': ref,
      'TransactionDesc': desc,
    }

    call(path, body)
  end

  def paybill
  end

  def callback_b2c
  end

  def callback_c2b
  end

  def callback_stk
  end

  def register_url
    path = "/mpesa/c2b/v1/registerurl"
    body = {
      'ShortCode': @C2B_PAYBILL,
      'ResponseType': "Completed",
      'ConfirmationURL': @CONFIRMATION_URL,
      'ValidationURL': @VALIDATION_URL,
    }

    call(path, body)
  end

  def validation
  end

  def access_token
    path = "/oauth/v1/generate?grant_type=client_credentials"
    base_url = @BASE_URL
    key = @MPESA_API_KEY
    secret = @MPESA_API_SECRET
    conn = Faraday.new(url: base_url + path) do |req|
      req.adapter Faraday.default_adapter
      req.basic_auth(key, secret)
    end
    request = conn.get
    render json: request
  end

  def b2c_token
  end

  def phone_format
  end

  def phone_format_b2c
  end

  def update_wallet
  end

  def mpesa_params
    params.require(:mpesa).permit(:phone, :amount)
  end

  private

  def call(path, body)
    base_url = @BASE_URL
    res = access_token()
    return res unless res.status == 200
    token = JSON.parse(res.body)["access_token"]
    headers = {
      'Accept': "application/json",
      'Content-Type': "application/json",
      'Authorization': "Bearer #{token}",
    }
    Faraday.post(base_url + path, body.to_json, headers)
  end

  def set_mpesa
    @MPESA_API_KEY = "a0rdeuPwoSqGv0HIlGBqZeMEocwIfjha"
    @MPESA_API_SECRET = "GC2ScUskImTOSaVR"
    @MPESA_API_PASSKEY = "b87283b3be82ed37fdfbed3209156575757720419a85088aec920583d05bcabc"

    @MPESA_SANDBOX_API_KEY = "TrnEPlNA2DD32e81MwGuqFm4Buliif5c"
    @MPESA_SANDBOX_API_SECRET = "qz9R5oXJAA3IH3yu"
    @MPESA_SANDBOX_API_PASSKEY = "b87283b3be82ed37fdfbed3209156575757720419a85088aec920583d05bcabc"

    @MPESA_B2C_API_KEY = "H9sp7IZjvZofvKIqmbDMFGu39N95FOEj"
    @MPESA_B2C_API_SECRET = "Rv52lKuXA0jfHBgE"
    @MPESA_B2C_API_PASSKEY = "mdlhTIiKm9B2y9gLxqSXvK/a7IPzGfCfLxU4lPcBMh4ZSiEuVElydgkofl6dJTbHv4rgdPPz4+16JoWWrG/g0rPv6QWlBLnUpAroZgIrN/vLHuMGPXpUVUDV/zNXLq6LppXfOTIRWTzFex2KpBqcQInl2/AXu2WAUN+l3kp+b8S/cEgAF0vGmH8qKS210W1fguTX11GxVdR+hhCoJSioCVtKYeRRyJ7IbgJUd1P7LkkCicM0QMP6A6pa6MWqfS14uHZhziQZPkjgZCOIuRx7MHHDebyjOPR4LEtYO9c0/1A4tBpVPCdOT+vtUJ1I5jBbg0ipKTBv63dM0FK9H1y2Cw=="

    @C2B_PAYBILL = 4072015
    @B2C_PAYBILL = 3012169
    @C2B_USERNAME = "sombo"
    @B2C_USERNAME = "sombob2c"

    @BASE_URL = "https://api.safaricom.co.ke"
    @TIMEOUT_URL = "https://prycely.com/validation"
    @RESULT_URL = "https://prycely.com/b2c"
    @CONFIRMATION_URL = "https://prycely.com/thecalls/c2b"
    @VALIDATION_URL = "https://prycely.com/thecalls/validation"

    @STK_CALLBACK = "https://prycely.com/stk-callback"
  end
end
