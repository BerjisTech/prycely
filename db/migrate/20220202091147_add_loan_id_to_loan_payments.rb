# frozen_string_literal: true

class AddLoanIdToLoanPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :loan_payments, :loan_id, :uuid
  end
end
