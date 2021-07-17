class CreateLoancategories < ActiveRecord::Migration[6.1]
  def change
    create_table :loancategories do |t|
      t.integer :group_id
      t.integer :created_by
      t.string :name
      t.integer :period
      t.text :decsription
      t.text :amount
      t.integer :interest
      t.text :interest_rule
      t.integer :required_guarantos
      t.text :requirements

      t.timestamps
    end
  end
end
