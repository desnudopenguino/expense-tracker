require 'rails_helper'
RSpec.describe ReceiptsController do
	it "renders the index view" do
		rec = create(:receipt)
		get :index
		expect(response).to be_successful
		expect(response).to render_template("index")
	end
	it "renders the show view" do
		rec = create(:receipt)
		get :show, params: { id: rec.id }
		expect(response).to be_successful
		expect(response).to render_template("show")
	end
end
