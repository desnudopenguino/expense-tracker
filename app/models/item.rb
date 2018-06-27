class Item < ApplicationRecord
    belongs_to :receipt

    validates :receipt_id, presence: true
    validates :name, presence: true
    validates :item_type, presence: true
    validates :cost, presence: true
    validates :qty, presence: true
end
