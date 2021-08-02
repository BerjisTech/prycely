class MpesaController < ApplicationController
  def index
  end

  def b2c
  end

  def c2b
  end

  def stk
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
  end

  def validation
  end

  def acces_token
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
end
