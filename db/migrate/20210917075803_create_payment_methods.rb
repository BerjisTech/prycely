# frozen_string_literal: true

class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods, id: :uuid do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
