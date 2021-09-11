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
    $MerchantRequestID = $request['Body']['stkCallback']['MerchantRequestID'];
            $CheckoutRequestID = $request['Body']['stkCallback']['CheckoutRequestID'];
            $ResultCode = $request['Body']['stkCallback']['ResultCode'];
            $ResultDesc = $request['Body']['stkCallback']['ResultDesc'];

            //initialize non-common variables
            $statusRes = 2;
            $stkRes = 3;

  end
end
