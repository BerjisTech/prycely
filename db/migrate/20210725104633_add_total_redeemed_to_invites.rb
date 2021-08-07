# frozen_string_literal: true

class AddTotalRedeemedToInvites < ActiveRecord::Migration[6.1]
  def change
    add_column :invites, :total_redeemed, :string
    add_index :invites, :total_redeemed
  end
end
