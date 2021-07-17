json.extract! paybill, :id, :request, :type, :transaction_reference, :paybill_balance, :third_party_transaction_id, :invoice_number, :amount, :first_name, :last_name, :middle_name, :phone, :short_code, :account_number, :created_at, :updated_at
json.url paybill_url(paybill, format: :json)
