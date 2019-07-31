class ChangeDatatypeOpentimeOfShops < ActiveRecord::Migration[5.2]
  def change
    change_column :shops, :opentime, :text
  end
end
