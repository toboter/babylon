class Engagement < ActiveRecord::Base
  attr_accessible :end, :person_id, :start, :creator_id, :updater_id
  
  stampable

  belongs_to :person
end
