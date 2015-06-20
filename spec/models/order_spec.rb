require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should validate_presence_of(:total_price) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:completed_at) }
  it do
    should validate_numericality_of(:total_price).
      is_greater_than_or_equal_to(0.01)
  end
  it do
    should validate_inclusion_of(:state).
      in_array(%w(in\ progress completed shipped))
  end

  it { should belong_to(:user) }
  it { should belong_to(:credit_card) }
  it { should belong_to(:billing_address).class_name('Address') }
  it { should belong_to(:shipping_address).class_name('Address') }
  it { should have_many(:order_items).dependent(:destroy) }
end
