class ChangeReceiptPurchaseDateToString < ActiveRecord::Migration[5.2]
  def change
    change_table :receipts do |t|
      t.change :purchase_date, :string
    end
  end
end
