class AddBudgetToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :budget, :integer
  end
end
