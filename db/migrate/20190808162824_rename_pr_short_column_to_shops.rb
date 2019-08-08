class RenamePrShortColumnToShops < ActiveRecord::Migration[5.2]
  def change
    rename_column :shops, :pr_short, :pr
  end
end
