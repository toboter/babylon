class AddExcavationDateToItems < ActiveRecord::Migration
  def change
    add_column :items, :excavation_date, :datetime
  end
end
