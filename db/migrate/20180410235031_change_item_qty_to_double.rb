class ChangeItemQtyToDouble < ActiveRecord::Migration[5.2]
  def change
    change_table :items do |t|
      t.change :qty, :float
    end
  end
end
