# frozen_string_literal: true

class AddBalanceToWallets < ActiveRecord::Migration[6.1]
  def change
    add_column :wallets, :balance, :float
  end
end
