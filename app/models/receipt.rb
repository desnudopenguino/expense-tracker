class Receipt < ApplicationRecord
    has_many :items

    validates :total, presence: true
    validates :tax, presence: true
    validates :store, presence: true
    validates :purchase_date, presence: true

end
