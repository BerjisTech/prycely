class AddUserIdToRedeems < ActiveRecord::Migration[6.1]
  def change
    add_column :redeems, :user_id, :integer
    add_index :redeems, :user_id
  end
end
