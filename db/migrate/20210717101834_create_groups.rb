# frozen_string_literal: true

class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :created_by
      t.text :currency
      t.text :group_type
      t.integer :membership

      t.timestamps
    end
  end
end
