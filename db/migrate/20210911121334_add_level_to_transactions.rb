class AddLevelToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :level, :integer
  end
end
