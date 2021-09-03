# frozen_string_literal: true

class AddSellingPriceToAssets < ActiveRecord::Migration[6.1]
  def change
    add_column :assets, :selling_price, :float
  end
end
