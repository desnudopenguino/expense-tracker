require 'rails_helper'
RSpec.describe Receipt, type: :model do
	it { is_expected.to validate_presence_of(:purchase_date) }
	it { is_expected.to validate_presence_of(:store) }
	it { is_expected.to validate_presence_of(:tax) }
	it { is_expected.to validate_presence_of(:total) }
end
