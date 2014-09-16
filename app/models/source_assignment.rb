class SourceAssignment < ActiveRecord::Base
  attr_accessible :action_id, :source_id, :target

  stampable

  belongs_to :action
  belongs_to :source
  
end
