class ProjectStudyField < ActiveRecord::Base
  attr_accessible :field_type, :name, :required, :creator_id, :updater_id, :select_values_attributes, :predicate_id
 
  stampable
  default_scope order('name ASC')

  belongs_to :project
  belongs_to :predicate
  
  has_many :select_values, class_name: 'ProjectStudyFieldValue'
  accepts_nested_attributes_for :select_values, allow_destroy: true

end
