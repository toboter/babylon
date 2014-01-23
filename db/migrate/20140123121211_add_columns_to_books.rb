class AddColumnsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :edition, :string
    add_column :books, :abbreviation, :string
  end
end
