class CreateNcbas < ActiveRecord::Migration[6.1]
  def change
    create_table :ncbas, id: :uuid do |t|

      t.timestamps
    end
  end
end
