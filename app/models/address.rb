class Address < ApplicationRecord
  belongs_to :province
  belongs_to :customer

  validates :type, :street, :city, :country, :postal_code, :customer_id, :province_id, presence: true
end
