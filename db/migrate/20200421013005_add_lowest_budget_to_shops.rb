class AddLowestBudgetToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :lowestBudget, :integer
  end
end
