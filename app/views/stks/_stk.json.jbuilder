# frozen_string_literal: true

json.extract! stk, :id, :transaction_reference, :merchant_request_id, :checkout_request_id, :response_code,
              :response_description, :custom_message, :status, :response_result_code, :response_result_description, :phone, :created_at, :updated_at
json.url stk_url(stk, format: :json)
