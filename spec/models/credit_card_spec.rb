require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:exp_month) }
  it { should validate_presence_of(:exp_year) }
  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }
  it { should validate_length_of(:number).is_equal_to(16) }
  it { should validate_length_of(:exp_month).is_equal_to(2) }
  it { should validate_length_of(:exp_year).is_equal_to(2) }

  it { should belong_to(:customer) }
  it { should have_many(:orders) }
end
