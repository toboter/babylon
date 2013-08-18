class Cluster < ActiveRecord::Base
  attr_accessible :name, :creator_id, :updater_id

  has_many :areas, dependent: :destroy
  has_many :projects, as: :projectable, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :destroy
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  
  def intro
  	documents.where(:document_type => 'Introduction').first.abstract
  end
end
