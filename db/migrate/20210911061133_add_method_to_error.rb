class AddMethodToError < ActiveRecord::Migration[6.1]
  def change
    add_column :errors, :method, :text
  end
end
