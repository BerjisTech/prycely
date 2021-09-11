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

  def self.update_stk(request)
    # when success
    resultCode = request['ResultCode']
    # initialize non-common variables
    statusRes = 2

    process_request_for_update(request, statusRes, stkRes, resultCode) if [0, '0'].include?(resultCode)
  end

  def self.process_request_for_update(_processed_request, request, resultCode)
    statusRes = 1 # 0 = pending 1 = success 2 = failed

    # amount = request['CallbackMetadata']['Item'][0]['Value']
    mpesaReceiptNumber = request['CallbackMetadata']['Item'][1]['Value']
    merchantRequestID = request['MerchantRequestID']
    checkoutRequestID = request['CheckoutRequestID']
    resultDesc = request['ResultDesc']

    update_success_stk(mpesaReceiptNumber, merchantRequestID, checkoutRequestID, resultCode, resultDesc, statusRes)
    Transaction.update_success_transaction(merchantRequestID, statusRes)
  end

  def self.update_success_stk(mpesaReceiptNumber, merchantRequestID, checkoutRequestID, resultCode, resultDesc, statusRes)
    @stk = {
      transaction_reference: mpesaReceiptNumber,
      merchant_request_id: merchantRequestID,
      checkout_request_id: checkoutRequestID,
      response_code: resultCode,
      response_description: resultDesc,
      status: statusRes
    }

    Model.where(merchant_request_id: merchantRequestID).update_all(@stk)
  end
end
