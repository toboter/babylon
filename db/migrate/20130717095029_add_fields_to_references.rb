class AddFieldsToReferences < ActiveRecord::Migration
  def change
    add_column :references, :first_page, :string
    add_column :references, :last_page, :string
    add_column :references, :volume, :string
  end
end
