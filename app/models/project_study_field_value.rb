class ProjectStudyFieldValue < ActiveRecord::Base
  attr_accessible :description, :field_value, :creator_id, :updater_id, :project_study_field_id

  belongs_to :project_study_field

  stampable
end
