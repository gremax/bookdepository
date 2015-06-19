class Address < ActiveRecord::Base
  belongs_to :country

  validates :address, :zipcode, :city, :phone, presence: true
  validates :zipcode, length: { is: 5 }
  validates :phone, length: { minimum: 5, maximum: 12 }
end
