require 'rails_helper'
RSpec.describe Api::ReceiptsController do
	it "GET data for all receipts" do
		3.times do
			create(:receipt)
		end
		get :index
		expect(response).to be_successful
		expect(json.length).to eq(3)
	end
	it "GET data for individual receipt" do
		rec = create(:receipt)
		get :show, params: { id: rec.id }
		expect(response).to be_successful
		expect(json['store']).to eq(rec.store)
	end
	it "POST new receipt" do
		attrs = attributes_for(:receipt)
		post :create, params: { receipt: attrs }
		expect(response).to be_successful
		expect(json['store']).to eq(attrs[:store])
	end
	it "PATCH update receipt" do
		rec = create(:receipt)
		new_store = "Test Store 2"
		patch :update, params: { id: rec.id, receipt: { store: new_store } }
		expect(response).to be_successful
		expect(json['id']).to eq(rec.id)
		expect(json['store']).to eq(new_store)
	end
	it "DELETE receipt" do
		rec = create(:receipt)
		delete :destroy, params: { id: rec.id }
		expect(response).to be_successful
		expect(response.body).to eq("")
	end
end
