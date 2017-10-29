class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.decimal :pst
      t.decimal :gst
      t.decimal :hst
      t.integer :customer_id

      t.timestamps
    end
  end
end
