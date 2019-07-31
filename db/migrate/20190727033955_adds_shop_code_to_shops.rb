class AddsShopCodeToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :shop_code, :string
  end
end
