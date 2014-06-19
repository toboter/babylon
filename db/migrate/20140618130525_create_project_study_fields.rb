class CreateProjectStudyFields < ActiveRecord::Migration
  def change
    create_table :project_study_fields do |t|
      t.string :field_type
      t.boolean :required
      t.belongs_to :project
      t.string :name

      t.timestamps
      t.userstamps
    end
    add_index :project_study_fields, :project_id

    add_column :lists, :accept_duplicates, :boolean
  end
end
