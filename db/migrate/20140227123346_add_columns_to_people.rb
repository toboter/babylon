class AddColumnsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :cv, :text
    add_column :people, :general, :text
  end
end
