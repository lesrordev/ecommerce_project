class Product < ApplicationRecord
  has_many :product_comments
  has_many :order_items
  has_many :orders, :through => :order_items
  belongs_to :category

  validates :name, :price, :stock_quantity, presence: true
  validates :price, :stock_quantity, numericality: { greater_than: 0 }
end
