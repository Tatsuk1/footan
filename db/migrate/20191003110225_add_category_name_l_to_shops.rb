class AddCategoryNameLToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :Category_name_l, :string
  end
end
