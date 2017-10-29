class OrderItem < ApplicationRecord
  belongs_to :products
  belongs_to :orders

  validates :price, :quantity, :product_id, :order_id, presence: true
  validates :price, :quantity, numericality: { greater_than: 0 }
end
