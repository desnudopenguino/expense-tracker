require 'rails_helper'
RSpec.describe Item, type: :model do
	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:item_type) }
	it { should validate_presence_of(:cost) }
	it { should validate_presence_of(:qty) }
	it { should validate_presence_of(:receipt_id) }
	it { should belong_to(:receipt) }
	it "checks if name is a String" do
		item = build(:item)
		expect(item[:name]).to be_a(String)
	end
	it "checks if item_type is a String" do
		item = build(:item)
		expect(item[:item_type]).to be_a(String)
	end
	it "checks if cost is a Float" do
		item = build(:item)
		expect(item[:cost]).to be_a(Float)
	end
	it "checks if qty is a Float" do
		item = build(:item)
		expect(item[:qty]).to be_a(Float)
	end
	it "checks if receipt_id is a Integer" do
		item = build(:item)
		expect(item[:receipt_id]).to be_a(Integer)
	end
end
