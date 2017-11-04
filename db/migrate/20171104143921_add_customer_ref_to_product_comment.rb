class AddCustomerRefToProductComment < ActiveRecord::Migration[5.1]
  def change
    add_reference :product_comments, :customer, foreign_key: true
  end
end
