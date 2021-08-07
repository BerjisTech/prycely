# frozen_string_literal: true

class AddUserIdToInvites < ActiveRecord::Migration[6.1]
  def change
    add_column :invites, :user_id, :integer
    add_index :invites, :user_id
  end
end
