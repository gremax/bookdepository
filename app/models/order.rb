class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :credit_card
  has_many :order_items
  has_one :billing_address
  has_one :shipping_address

  validates :total_price, :state, :completed_at, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :state, inclusion: { in: %w(in\ progress completed shipped) }
end
