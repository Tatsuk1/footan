class AddFreewordToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :freeword, :string
  end
end
