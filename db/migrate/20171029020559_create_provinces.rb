class CreateProvinces < ActiveRecord::Migration[5.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :code
      t.decimal :pst
      t.decimal :gst
      t.decimal :hst

      t.timestamps
    end
  end
end
