# frozen_string_literal: true

class CreateLoanPayments < ActiveRecord::Migration[6.1]
  def change
    drop_table :loan_payments
    create_table :loan_payments, id: :uuid do |t|
      t.float :amount
      t.uuid :group_id
      t.uuid :user_id
      t.uuid :loan_id

      t.timestamps
    end
  end
end
