class Card < ApplicationRecord
  belongs_to :customer

  validates :type, :name, :number, :verification_number, :due_date, :customer_id, presence: true
end
