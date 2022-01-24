# frozen_string_literal: true

class DestroyTableAsset < ActiveRecord::Migration[6.1]
  def change
    drop_table :assets
  end
end
