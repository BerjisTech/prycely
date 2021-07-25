class AddActiveActiveToInvites < ActiveRecord::Migration[6.1]
  def change
    add_column :invites, :active, :integer
  end
end
