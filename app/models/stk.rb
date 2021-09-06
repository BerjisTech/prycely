# frozen_string_literal: true

class Stk < ApplicationRecord
  def self.create_stk(response, phone, status)
    Stk.create(
      transaction_reference: response['MpesaReceiptNumber'],
      merchant_request_id: response['MerchantRequestID'],
      checkout_request_id: response['CheckoutRequestID'],
      response_code: response['ResponseCode'],
      response_description: response['ResponseDescription'],
      custom_message: response['CustomerMessage'],
      status: status,
      response_result_code: response['ResultCode'],
      response_result_description: response['ResultDesc'],
      phone: phone
    )
  end

  def self.update_stk; end
end
