class Receipt < ApplicationRecord
	has_many :items, dependent: :delete_all

	validates :total, presence: true
	validates :tax, presence: true
	validates :store, presence: true
	validates :purchase_date, presence: true

	def check_total
		(subtotal + tax).round(2) == total
	end

	def subtotal
		subtotal = 0
		items.each do |item|
			subtotal += item.total_cost
		end
		return subtotal
	end
end
