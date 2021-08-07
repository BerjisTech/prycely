# frozen_string_literal: true

class CreateStks < ActiveRecord::Migration[6.1]
  def change
    create_table :stks do |t|
      t.string :transaction_reference
      t.text :merchant_request_id
      t.text :checkout_request_id
      t.integer :response_code
      t.text :response_description
      t.text :custom_message
      t.integer :status
      t.integer :response_result_code
      t.text :response_result_description
      t.text :phone

      t.timestamps
    end
  end
end
