# frozen_string_literal: true

class CreateInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :invites do |t|
      t.integer :group_id
      t.text :invite_key
      t.integer :max_redeem
      t.text :invite_email

      t.timestamps
    end
    add_index :invites, :invite_key, unique: true
  end
end
