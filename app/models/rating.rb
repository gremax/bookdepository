class Rating < ActiveRecord::Base
  validates :score, inclusion: { in: 1..10 }
end
