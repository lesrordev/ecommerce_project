class Card < ApplicationRecord
  belongs_to :customers

  validates :type, :name, :number, :verification_number, :due_date, :customer_id, presence: true
end
