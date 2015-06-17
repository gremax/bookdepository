class CreditCard < ActiveRecord::Base
  belongs_to :customer
  has_many :orders

  validates :number, :exp_month, :exp_year, :firstname, :lastname, presence: true
  validates :number, length: { is: 16 }
  validates :exp_month, :exp_year, length: { is: 2 }
end
