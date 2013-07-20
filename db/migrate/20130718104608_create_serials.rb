class CreateSerials < ActiveRecord::Migration
  def change
    create_table :serials do |t|
      t.string :name
      t.string :shortcut
      t.string :serial_identifier
      t.string :uri

      t.timestamps
      t.userstamps
    end
  end
end
