class CreateSiris < ActiveRecord::Migration[6.1]
  def change
    create_table :siris do |t|
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
