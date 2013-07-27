class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name

      t.timestamps
      t.userstamps
    end
  end
end
