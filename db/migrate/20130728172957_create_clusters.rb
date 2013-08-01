class CreateClusters < ActiveRecord::Migration
  def change
    create_table :clusters do |t|
      t.string :name

      t.timestamps
      t.userstamps
    end

    add_column :areas, :cluster_id, :integer
  end
end
