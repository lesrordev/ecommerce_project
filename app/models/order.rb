class Order < ApplicationRecord
  has_many :order_items
  has_many :orders, :through => :order_items
  belongs_to :customers

  validates :status, :customer_id, presence: true
end
