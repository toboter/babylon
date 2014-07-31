class AddSortOrderToItemClassifications < ActiveRecord::Migration
  def change
    add_column :item_classifications, :sort_order, :integer
  end
end
