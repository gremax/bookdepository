class User < ActiveRecord::Base
  has_secure_password

  has_many :orders, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :firstname, :lastname, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def current_order
    self.orders.in_progress.first
  end
end
