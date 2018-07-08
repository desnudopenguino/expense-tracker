FactoryBot.define do
	factory :item do
		name		"item1"
		item_type	"test"
		cost		5.95
		qty		2
		receipt
	end
	factory :receipt do
		purchase_date	'2018-01-01 00:00:00'
		store		"Awesome Store"
		tax 		2.85
		total 		38.55
		factory :receipt_with_items do
			transient do
				items_count 3
			end
			after(:create) do |receipt,evaluator|
				create_list(:item, evaluator.items_count, receipt: receipt)
			end
		end
	end
end
