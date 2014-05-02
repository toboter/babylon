class AddDocumentfileinfoToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :documentfile_content_type, :string
    add_column :documents, :documentfile_name, :string
    add_column :documents, :documentfile_upload_date, :datetime
    add_column :documents, :documentfile_size, :string
  end
end
