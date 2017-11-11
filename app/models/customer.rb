class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :product_comments, dependent: :destroy

  validates :name, :email, :password, presence: true
end
