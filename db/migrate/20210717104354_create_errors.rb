# frozen_string_literal: true

class CreateErrors < ActiveRecord::Migration[6.1]
  def change
    create_table :errors do |t|
      t.text :error
      t.timestamp :time

      t.timestamps
    end
  end
end
