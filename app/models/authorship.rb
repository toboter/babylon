class Authorship < ActiveRecord::Base
  attr_accessible :person_id, :position, :predicate_id, :reference_id, :creator_id, :updater_id

  stampable
  acts_as_list :scope => :reference

  belongs_to :person
  belongs_to :reference
end
