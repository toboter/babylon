class AddExcavationIndexToItem < ActiveRecord::Migration
  def change
    add_column :items, :excavation_index, :string
    rename_column :items, :excavation_id, :excavation_number
  end
end
