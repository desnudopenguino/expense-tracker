require 'rails_helper'
RSpec.describe Item, type: :model do
	it { is_expected.to validate_presence_of(:name) }
	it { is_expected.to validate_presence_of(:item_type) }
	it { is_expected.to validate_presence_of(:cost) }
	it { is_expected.to validate_presence_of(:qty) }
	it { is_expected.to validate_presence_of(:receipt_id) }
end
