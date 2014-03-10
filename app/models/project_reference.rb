class ProjectReference < ActiveRecord::Base
  attr_accessible :project_id, :reference_id, :creator_id, :updater_id

  belongs_to :project
  belongs_to :reference

  validates :reference_id, :uniqueness => {:scope => :project_id}
  validates_presence_of :reference_id, :project_id
end
