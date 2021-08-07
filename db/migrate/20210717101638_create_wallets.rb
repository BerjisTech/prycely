# frozen_string_literal: true

class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.integer :user_id
      t.text :currency

      t.timestamps
    end
    add_index :wallets, :user_id
  end
end
