# frozen_string_literal: true

class CreatePaybills < ActiveRecord::Migration[6.1]
  def change
    create_table :paybills do |t|
      t.text :request
      t.string :paybill_type
      t.string :transaction_reference
      t.float :paybill_balance
      t.text :third_party_transaction_id
      t.text :invoice_number
      t.float :amount
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.text :phone
      t.integer :short_code
      t.text :account_number

      t.timestamps
    end
  end
end
