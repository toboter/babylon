class AddAbstractToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :abstract, :text
  end
end
