class CreateProjectReferences < ActiveRecord::Migration
  def change
    create_table :project_references do |t|
      t.integer :project_id
      t.integer :reference_id

      t.timestamps
      t.userstamps
    end

    add_column :projects, :show_references, :boolean
  end
end
