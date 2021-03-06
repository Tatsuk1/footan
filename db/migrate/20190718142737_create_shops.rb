class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :name
      t.decimal :latitude, :precision => 10, :scale => 7
      t.decimal :longitude, :precision => 10, :scale => 7
      t.string :shop_url
      t.string :image_url
      t.string :address
      t.string :tel
      t.string :opentime
      t.string :holiday

      t.timestamps
    end
  end
end
