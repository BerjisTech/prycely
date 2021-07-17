class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.float :amount
      t.integer :status
      t.timestamp :project_start
      t.timestamp :project_end
      t.integer :created_by
      t.integer :group_id
      t.text :currency

      t.timestamps
    end
  end
end
