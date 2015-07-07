require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:book) { create(:book) }
  let(:order) { build(:order) }

  before { order.add_book(book) }

  describe 'validation' do
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
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:credit_card) }
    it { should belong_to(:billing_address).class_name('Address') }
    it { should belong_to(:shipping_address).class_name('Address') }
    it { should have_many(:order_items).dependent(:destroy) }
  end

  describe '.in_progress' do
    let(:orders) { create_list(:order_with_random_state, 5) }

    it 'doesn\'t return all orders'  do
      expect(orders).to_not match_array(Order.in_progress)
    end

    it 'returns orders in progress' do
      expect(Order.in_progress).to match_array(Order.where(state: 'in progress'))
    end
  end

  describe '.add_book' do
    it 'adds a book to the order' do
      expect(order.order_items.last.book).to eq book
    end

    it 'doesn\'t return the same book twice' do
      expect { order.add_book(book) }.to_not change { order.order_items }
    end

    it 'increments order item quantity' do
      expect { order.add_book(book) }.
        to change { order.order_items.last.quantity }.from(1).to(2)
    end
  end

  describe '.calc_total_price' do
    it 'returns total price for an order item' do
      expect(order.calc_total_price).to eq book.price
    end

    it 'returns total price for several order items' do
      order.add_book(book)
      expect { order.calc_total_price }.
        to change { order.total_price }.from(9.99).to(19.98)
    end
  end
end
