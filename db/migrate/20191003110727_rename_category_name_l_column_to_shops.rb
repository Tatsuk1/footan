class RenameCategoryNameLColumnToShops < ActiveRecord::Migration[5.2]
  def change
    rename_column :shops, :Category_name_l, :category_name_l
  end
end
