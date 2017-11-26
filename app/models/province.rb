class Province < ApplicationRecord
  has_many :addresses, dependent: :nullify

  validates :name, presence: true
  validates :code, length: { is: 2 }
end
