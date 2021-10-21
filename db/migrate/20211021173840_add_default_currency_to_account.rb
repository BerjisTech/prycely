# frozen_string_literal: true

class AddDefaultCurrencyToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :default_currency, :string
  end
end
