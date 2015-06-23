class Author < ActiveRecord::Base
  has_many :books, dependent: :destroy

  validates :firstname, :lastname, presence: true

  def full_name
    "#{self.firstname} #{self.lastname}"
  end
end
