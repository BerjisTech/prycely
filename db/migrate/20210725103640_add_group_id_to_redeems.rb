# frozen_string_literal: true

class AddGroupIdToRedeems < ActiveRecord::Migration[6.1]
  def change
    add_column :redeems, :group_id, :integer
    add_index :redeems, :group_id
  end
end
