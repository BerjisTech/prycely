class CreateGrouptypes < ActiveRecord::Migration[6.1]
  def change
    create_table :grouptypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
