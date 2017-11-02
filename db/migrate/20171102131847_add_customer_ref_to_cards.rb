class AddCustomerRefToCards < ActiveRecord::Migration[5.1]
  def change
    add_reference :cards, :customer, foreign_key: true
  end
end
