class AddProductRefToProductComment < ActiveRecord::Migration[5.1]
  def change
    add_reference :product_comments, :product, foreign_key: true
  end
end
