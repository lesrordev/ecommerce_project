class Province < ApplicationRecord
  has_many :addresses

  validates :name, :code, presence: true
  validates :code, length: { is: 2 }
end
