# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :phone
      t.string :first_name
      t.string :last_name
      t.text :photo
      t.timestamp :deactivated
      t.string :verified
      t.string :country
      t.string :county
      t.string :city
      t.string :street
      t.string :address
      t.string :postal
      t.string :account_type
      t.string :tour

      t.timestamps
    end
  end
end
