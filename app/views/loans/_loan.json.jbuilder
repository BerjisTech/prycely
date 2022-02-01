# frozen_string_literal: true

json.extract! loan, :id, :group_id, :created_by, :user_id, :amount, :amount_paid, :loan_type, :amount_due, :interest, :status,
              :guarantors, :date_granted, :date_due, :date_paid, :requirements, :created_at, :updated_at
json.url loan_url(loan, format: :json)
