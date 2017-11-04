class AddProvinceRefToAddress < ActiveRecord::Migration[5.1]
  def change
    add_reference :addresses, :province, foreign_key: true
  end
end
