class AddCustomerBudgetToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :customerBudget, :integer
  end
end
