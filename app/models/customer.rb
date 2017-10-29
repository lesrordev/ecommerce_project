class Customer < ApplicationRecord
  has_many :orders
  has_many :cards
  has_many :addresses

  validates :name, :email, :password, presence: true
end
