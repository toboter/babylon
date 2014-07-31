class Authorship < ActiveRecord::Base
  attr_accessible :person_name_id, :position, :predicate_id, :reference_id, :creator_id, :updater_id

  default_scope :order => 'position'

  stampable
  acts_as_list :scope => :reference

  belongs_to :person_name
  belongs_to :reference

  validates_uniqueness_of :person_name_id, :scope => :reference_id

end
