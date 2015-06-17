class Rating < ActiveRecord::Base
  belongs_to :book

  validates :score, inclusion: { in: 1..10 }
end
