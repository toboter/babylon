class AddFieldsToClusters < ActiveRecord::Migration
  def change
    add_column :clusters, :speaker_id, :integer
    add_column :clusters, :cluster_admin_id, :integer
  end
end
