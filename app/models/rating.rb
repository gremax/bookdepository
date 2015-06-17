class Rating < ActiveRecord::Base
  belongs_to :book
  belongs_to :customer

  validates :score, inclusion: { in: 1..10 }
end
