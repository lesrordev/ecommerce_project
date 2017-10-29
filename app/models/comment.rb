class Comment < ApplicationRecord
  belongs_to :products
  belongs_to :customers

  validates :content, :customer_id, :product_id, presence: true
end
