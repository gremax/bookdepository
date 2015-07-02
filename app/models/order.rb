class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :credit_card
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'

  has_many :order_items, dependent: :destroy

  validates :total_price, :state, :completed_at, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :state, inclusion: { in: %w(in\ progress completed shipped) }

  scope :in_progress, -> { where(state: 'in progress') }

  def add_book(book)
    current_item = order_items.where(book: book).first
    if current_item
      current_item.increment(:quantity)
    else
      current_item = order_items.build(book: book, quantity: 1)
      current_item.price = book.price
    end
    current_item.save
  end
end
