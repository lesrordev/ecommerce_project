class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :description
      t.string :type
      t.string :street
      t.string :city
      t.string :country
      t.string :postal_code
      t.integer :customer_id

      t.timestamps
    end
  end
end
