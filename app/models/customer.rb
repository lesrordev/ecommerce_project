class Customer < ApplicationRecord
  has_many :orders
  has_many :cards
  has_many :addresses
  has_many :product_comments

  validates :name, :email, :password, presence: true
end
