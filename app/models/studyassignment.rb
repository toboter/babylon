class Studyassignment < ActiveRecord::Base
  attr_accessible :item_id, :project_id, :creator_id, :updater_id

  belongs_to :item
  belongs_to :project
end
