class RemovePages < ActiveRecord::Migration
  def change
  	remove_index :pages, :permalink
  	drop_table :pages
  end
end
