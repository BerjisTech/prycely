class AddCreatorIdToInvites < ActiveRecord::Migration[6.1]
  def change
    add_column :invites, :creator_id, :integer
    add_index :invites, :creator_id
  end
end
