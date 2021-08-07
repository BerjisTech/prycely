# frozen_string_literal: true

class AddAccountToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :account_id, :integer
  end
end
