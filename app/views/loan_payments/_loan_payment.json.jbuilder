# frozen_string_literal: true

json.extract! loan_payment, :id, :amount, :group_id, :user_id, :loan_id, :created_at, :updated_at
json.url loan_payment_url(loan_payment, format: :json)
