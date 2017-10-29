class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :type
      t.string :name
      t.string :number
      t.string :verification_number
      t.datetime :due_date
      t.integer :customer_id

      t.timestamps
    end
  end
end
