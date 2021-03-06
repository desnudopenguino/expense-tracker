require 'rails_helper'
RSpec.describe Receipt, type: :model do
	it { should validate_presence_of(:purchase_date) }
	it { should validate_presence_of(:store) }
	it { should validate_presence_of(:tax) }
	it { should validate_presence_of(:total) }
	it { should have_many(:items) }
	it "checks if purchase_date is a DateTime" do
		rec = create(:receipt)
		expect(DateTime.parse(rec[:purchase_date])).to be_a(DateTime)
	end
	it "checks if store is a String" do
		rec = create(:receipt)
		expect(rec[:store]).to be_a(String)
	end
	it "checks if tax is a Float" do
		rec = create(:receipt)
		expect(rec[:tax]).to be_a(Float)
	end
	it "checks if total is a Float" do
		rec = create(:receipt)
		expect(rec[:total]).to be_a(Float)
	end
	it "checks if delete cascades to items in a receipt" do
		rec = create(:receipt_with_items)
		rec.destroy
		expect(Item.count).to be(0)
	end
	it "checks if subtotal + tax = total" do
		rec = create(:receipt_with_items)
		expect(rec.check_total).to be(true)
	end
end
