class Product < ApplicationRecord
  has_many :product_comments, dependent: :destroy
  has_many :order_items, dependent: :nullify
  has_many :orders, through: :order_items
  belongs_to :category

  validates :name, :price, :stock_quantity, presence: true
  validates :price, :stock_quantity, numericality: { greater_than_or_equal_to: 0 }

  max_paginates_per 8

  mount_uploader :image, ProductUploader

  def self.search(search, category)
    query = "(name ILIKE '%#{search}%' OR description ILIKE '%#{search}%')"
    query += " AND category_id = #{category}" if category > 0
    where(query)
  end
end
