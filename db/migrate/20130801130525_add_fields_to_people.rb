class AddFieldsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :phone, :string
    add_column :people, :fax, :string
    add_column :people, :uri, :string
    add_column :people, :institute_id, :integer
  end
end
