class ChangeActionDateToText < ActiveRecord::Migration
  def change
  	remove_column :actions, :actable_date
  	add_column :actions, :actable_date_text, :string
  end
end
