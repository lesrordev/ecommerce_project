class Address < ApplicationRecord
  belongs_to :provinces
  belongs_to :customers

  validates :type, :street, :city, :country, :postal_code, :customer_id, :province_id, presence: true
end
