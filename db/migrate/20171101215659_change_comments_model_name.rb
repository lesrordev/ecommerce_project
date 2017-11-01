class ChangeCommentsModelName < ActiveRecord::Migration[5.1]
  def change
    rename_table :comments, :product_comments
  end
end
