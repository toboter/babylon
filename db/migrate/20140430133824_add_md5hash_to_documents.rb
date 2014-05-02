class AddMd5hashToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :documentfile_md5hash, :string
  end
end
