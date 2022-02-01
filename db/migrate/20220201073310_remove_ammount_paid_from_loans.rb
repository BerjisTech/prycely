# frozen_string_literal: true

class RemoveAmmountPaidFromLoans < ActiveRecord::Migration[6.1]
  def change
    remove_column :loans, :ammount_paid
    add_column :loans, :amount_paid, :float, default: 0.0
  end
end
