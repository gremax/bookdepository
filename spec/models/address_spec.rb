require 'rails_helper'

RSpec.describe Address, type: :model do
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:phone) }
  it { should validate_length_of(:zipcode).is_equal_to(5) }
  it { should validate_length_of(:phone).is_at_least(5).is_at_most(12) }

  it { should belong_to(:country) }
  it do
    should have_many(:billing_orders).
      class_name('Order').
      with_foreign_key('billing_address_id')
  end
  it do
    should have_many(:shipping_orders).
      class_name('Order').
      with_foreign_key('shipping_address_id')
  end
end
