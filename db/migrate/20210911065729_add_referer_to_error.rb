class AddRefererToError < ActiveRecord::Migration[6.1]
  def change
    add_column :errors, :referer, :text
  end
end
