FactoryBot.define do
	factory :receipt do
		purchase_date	"2018-01-01 00:00:00"
		store		"Awesome Story"
		tax 		80
		total 		1080
	end

	factory :item do
		name		"item1"
		item_type	"test"
		cost		5.95
		qty		2
		receipt
	end
end

