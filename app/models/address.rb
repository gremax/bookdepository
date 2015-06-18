class Address < ActiveRecord::Base
  belongs_to :country

  has_many :billing_orders, class_name: 'Order',
    foreign_key: 'billing_address_id'
  has_many :shipping_orders, class_name: 'Order',
    foreign_key: 'shipping_address_id'

  validates :address, :zipcode, :city, :phone, presence: true
  validates :zipcode, length: { is: 5 }
  validates :phone, length: { minimum: 5, maximum: 12}
end
