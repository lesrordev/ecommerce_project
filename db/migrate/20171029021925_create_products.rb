class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :stock_quantity
      t.string :category

      t.timestamps
    end
  end
end
