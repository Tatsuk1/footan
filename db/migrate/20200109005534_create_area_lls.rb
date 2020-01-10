class CreateAreaLls < ActiveRecord::Migration[5.2]
  def change
    create_table :area_lls do |t|
      t.string :areacode_l
      t.string :areaname_l

      t.timestamps
    end
  end
end
