class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts do |t|
      t.integer :purchase_date
      t.text :store
      t.float :tax
      t.float :total

      t.timestamps
    end
  end
end
