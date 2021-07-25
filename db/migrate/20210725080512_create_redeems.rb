class CreateRedeems < ActiveRecord::Migration[6.1]
  def change
    create_table :redeems do |t|
      t.integer :invite_id

      t.timestamps
    end
    add_index :redeems, :invite_id
  end
end
