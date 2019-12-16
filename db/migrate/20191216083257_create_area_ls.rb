class CreateAreaLs < ActiveRecord::Migration[5.2]
  def change
    create_table :area_ls do |t|
      t.string :areacode_l
      t.string :areaname_l
      t.references :pref, foreign_key: true

      t.timestamps
    end
  end
end
