class Group < ActiveRecord::Base
  attr_accessible :name, :cluster_id, :creator_id, :updater_id, :speaker_id, :group_admin_id, :description

  stampable

  has_many :projects, as: :projectable, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :destroy
  belongs_to :cluster
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :speaker, class_name: "User"
  belongs_to :group_admin, class_name: "User"

  validates_presence_of :name, :cluster_id, :speaker_id, :group_admin_id
  validates :name, :uniqueness => {:scope => :cluster_id}

end
