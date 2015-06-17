class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  validates :price, :quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
