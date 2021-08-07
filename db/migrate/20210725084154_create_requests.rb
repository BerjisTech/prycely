# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.integer :group_id
      t.integer :user_id
      t.integer :account_id
      t.text :emai
      t.integer :accept

      t.timestamps
    end
    add_index :requests, :group_id
  end
end
