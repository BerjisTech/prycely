# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.string :title
      t.text :description
      t.timestamp :date
      t.integer :created_by
      t.integer :group_id
      t.float :price
      t.float :fine
      t.text :host
      t.text :host_contact

      t.timestamps
    end
  end
end
