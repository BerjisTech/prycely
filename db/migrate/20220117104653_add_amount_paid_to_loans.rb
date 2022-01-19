# frozen_string_literal: true

class AddAmountPaidToLoans < ActiveRecord::Migration[6.1]
  def change
    add_column :loans, :ammount_paid, :float, default: 0.0
  end
end
