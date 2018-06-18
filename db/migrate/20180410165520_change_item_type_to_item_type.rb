class ChangeItemTypeToItemType < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :type, :item_type
  end
end
