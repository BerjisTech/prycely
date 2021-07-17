class CreateCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :currencies do |t|
      t.string :currency
      t.string :code
      t.string :country
      t.string :country_code

      t.timestamps
    end
  end
end
