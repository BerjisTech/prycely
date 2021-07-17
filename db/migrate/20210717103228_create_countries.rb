class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.integer :phone_code
      t.text :country_code
      t.text :country_name

      t.timestamps
    end
  end
end
