require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:quantity) }
  it do
    should validate_numericality_of(:price).
      is_greater_than_or_equal_to(0.01)
  end

  it { should belong_to(:book) }
  it { should belong_to(:order) }
end
