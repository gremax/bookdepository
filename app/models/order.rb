class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :credit_card
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'

  has_many :order_items, dependent: :destroy

  validates :total_price, :state, :completed_at, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :state, inclusion: { in: %w(in\ progress completed shipped) }
end
