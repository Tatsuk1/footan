class AddPrShortToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :pr_short, :string
  end
end
