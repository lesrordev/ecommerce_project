class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  belongs_to :customer

  validates :status, :customer_id, presence: true
end
