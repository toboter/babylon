class ProjectStudyField < ActiveRecord::Base
  attr_accessible :field_type, :name, :required, :creator_id, :updater_id
  
  belongs_to :project
 
  stampable

  default_scope order('name ASC')

end
