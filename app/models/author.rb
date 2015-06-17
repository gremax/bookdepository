class Author < ActiveRecord::Base
  validates :firstname, :lastname, presence: true
end
