class AddDescriptionsToClusters < ActiveRecord::Migration
  def change
  	add_column :clusters, :description, :text
  	add_column :clusters, :contact, :text
  end
end
