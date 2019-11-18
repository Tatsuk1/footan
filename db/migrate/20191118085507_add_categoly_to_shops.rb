class AddCategolyToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :category_l, :string
    add_column :shops, :category_s, :string
  end
end
