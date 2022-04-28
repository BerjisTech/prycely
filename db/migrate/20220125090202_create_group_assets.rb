# frozen_string_literal: true

class CreateGroupAssets < ActiveRecord::Migration[6.1]
  def change
    create_table :group_assets, id: :uuid do |t|
      t.text :name
      t.text :description
      t.uuid :group_id
      t.datetime :date_bought
      t.datetime :date_sold
      t.uuid :user_id
      t.float :price
      t.uuid :project_id
      t.float :selling_price

      t.timestamps
    end
  end
end
