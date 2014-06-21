class CreateProjectStudyFieldValues < ActiveRecord::Migration
  def change
    create_table :project_study_field_values do |t|
      t.string :field_value
      t.text :description
      t.belongs_to :project_study_field

      t.timestamps
      t.userstamps
    end
    add_index :project_study_field_values, :project_study_field_id
  end
end
