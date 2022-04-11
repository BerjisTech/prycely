class AddMemberNumberToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :member_number, :integer
  end
end
