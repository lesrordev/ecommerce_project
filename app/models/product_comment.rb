class ProductComment < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  validates :content, :customer_id, :product_id, presence: true
end
