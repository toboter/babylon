class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :permalink

      t.timestamps
      t.userstamps
    end
    add_index :pages, :permalink
  end
end
