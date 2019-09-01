class AddDetailsToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :wifi, :integer
    add_column :shops, :outret, :integer
    add_column :shops, :takeout, :integer
    add_column :shops, :line, :string
    add_column :shops, :station, :string
    add_column :shops, :station_exit, :string
    add_column :shops, :walk, :integer
  end
end
