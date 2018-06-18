json.extract! receipt, :id, :purchase_date, :store, :tax, :total, :created_at, :updated_at
json.url receipt_url(receipt, format: :json)
