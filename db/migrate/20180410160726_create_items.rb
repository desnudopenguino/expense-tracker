class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :receipt_id
      t.text :name
      t.float :cost
      t.integer :qty
      t.text :type

      t.timestamps
    end
  end
end
