class AddCompleteToRedeems < ActiveRecord::Migration[6.1]
  def change
    add_column :redeems, :complete, :integer
  end
end
