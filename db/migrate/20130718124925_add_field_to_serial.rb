class AddFieldToSerial < ActiveRecord::Migration
  def change
    add_column :serials, :serial_type, :string
  end
end
