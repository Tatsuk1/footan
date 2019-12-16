class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :category_l_code
      t.string :category_l_name

      t.timestamps
    end
  end
end
