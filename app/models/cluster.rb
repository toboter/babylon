class Cluster < ActiveRecord::Base
  attr_accessible :name, :creator_id, :updater_id

  has_many :areas
  has_many :projects, as: :projectable
  has_many :documents, as: :documentable
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  
  
end
