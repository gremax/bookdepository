class Country < ActiveRecord::Base
  has_many :addresses, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
