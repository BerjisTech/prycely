# frozen_string_literal: true

class AddCurrencyToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :currency, :text
  end
end
