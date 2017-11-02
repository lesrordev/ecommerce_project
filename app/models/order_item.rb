class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :price, :quantity, :product_id, :order_id, presence: true
  validates :price, :quantity, numericality: { greater_than: 0 }
end
