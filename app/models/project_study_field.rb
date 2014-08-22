class ProjectStudyField < ActiveRecord::Base
  attr_accessible :field_type, :name, :required, :creator_id, :updater_id, :select_values_attributes, :predicate_id
 
  stampable
  default_scope order('name ASC')

  belongs_to :project
  belongs_to :predicate
  
  has_many :select_values, class_name: 'ProjectStudyFieldValue'
  accepts_nested_attributes_for :select_values, allow_destroy: true

  before_validation :strip_whitespace

  private
  def strip_whitespace
    self.name = self.name.squish.downcase.tr(" ","_")
  end
  
end
