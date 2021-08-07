# frozen_string_literal: true

class CreateLiabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :liabilities do |t|
      t.string :name
      t.text :description
      t.integer :group_id
      t.timestamp :date_bought
      t.timestamp :date_sold
      t.integer :added_by
      t.float :price

      t.timestamps
    end
  end
end
