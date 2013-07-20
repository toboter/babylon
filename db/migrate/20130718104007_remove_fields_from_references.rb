class RemoveFieldsFromReferences < ActiveRecord::Migration
  def up
  	remove_column :references, :publisher
	remove_column :references, :place
	remove_column :references, :reference_type_id
	remove_column :references, :signatory
	remove_column :references, :book_identifier
	remove_column :references, :volume
	remove_column :references, :ancestry

	add_column :references, :book_id, :integer
	add_column :references, :uri, :string
  end

  def down
  	add_column :references, :publisher, :integer
	add_column :references, :place, :integer
	add_column :references, :reference_type_id, :integer
	add_column :references, :signatory, :string
	add_column :references, :book_identifier, :string
	add_column :references, :volume, :string
	add_column :references, :ancestry, :string

  	remove_column :references, :book_id
  	remove_column :references, :uri
  end
end
