json.extract! item, :id, :receipt_id, :name, :cost, :qty, :item_type, :created_at, :updated_at
json.url receipt_item_path(item.receipt_id,item, format: :json)
