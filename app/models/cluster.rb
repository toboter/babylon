class Cluster < ActiveRecord::Base
  attr_accessible :name, :creator_id, :updater_id, :speaker_id, :cluster_admin_id

  has_many :groups, dependent: :destroy
  has_many :group_projects, through: :groups, source: 'projects'
  has_many :projects, as: :projectable, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :destroy
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :speaker, class_name: "User"
  belongs_to :cluster_admin, class_name: "User"

  validates_presence_of :name, :speaker_id, :cluster_admin_id
  validates_uniqueness_of :name

end
