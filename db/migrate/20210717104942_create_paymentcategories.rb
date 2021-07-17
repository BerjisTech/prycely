class CreatePaymentcategories < ActiveRecord::Migration[6.1]
  def change
    create_table :paymentcategories do |t|
      t.integer :group_id
      t.integer :created_by
      t.integer :type
      t.text :name

      t.timestamps
    end
  end
end
