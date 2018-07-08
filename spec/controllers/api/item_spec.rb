require 'rails_helper'
RSpec.describe Api::ItemsController do
	it "GET data for all items" do
		rec = create(:receipt_with_items)
		get :index, params: { receipt_id: rec.id }
		expect(response).to be_successful
		expect(json.length).to eq(3)
	end
	it "GET data for individual item" do
		itm = create(:item)
		get :show, params: { receipt_id: itm.receipt_id, id: itm.id }
		expect(response).to be_successful
		expect(json['name']).to eq(itm.name)
	end
	it "POST new item" do
		rec = create(:receipt)
		attrs = attributes_for(:item)
		post :create, params: { receipt_id: rec.id, item: attrs }
		expect(response).to be_successful
		expect(json['name']).to eq(attrs[:name])
	end
	it "PATCH update item" do
		itm = create(:item)
		new_name = "item2"
		patch :update, params: { receipt_id: itm.receipt_id, id: itm.id, item: { name: new_name } }
		expect(response).to be_successful
		expect(json['id']).to eq(itm.id)
		expect(json['name']).to eq(new_name)
	end
	it "DELETE item" do
		itm = create(:item)
		delete :destroy, params: { receipt_id: itm.receipt_id, id: itm.id }
		expect(response).to be_successful
		expect(response.body).to eq("")
	end
end
