# frozen_string_literal: true

json.extract! transaction, :id, :user_id, :amount, :transaction_reference, :transaction_type, :group_id, :wallet_id, :level,
              :status, :transaction_mode, :description, :category, :sub_category, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
