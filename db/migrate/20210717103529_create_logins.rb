# frozen_string_literal: true

class CreateLogins < ActiveRecord::Migration[6.1]
  def change
    create_table :logins do |t|
      t.integer :user_id
      t.timestamp :time
      t.string :ip
      t.string :success
      t.text :password_attempt

      t.timestamps
    end
  end
end
