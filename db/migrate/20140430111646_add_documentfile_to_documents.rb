class AddDocumentfileToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :documentfile, :string
  end
end
