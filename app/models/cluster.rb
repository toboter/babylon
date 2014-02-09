class Cluster < ActiveRecord::Base
  attr_accessible :name, :creator_id, :updater_id, :speaker_id, :cluster_admin_id, :description, :contact

  after_create :build_cluster_picture_bucket

  has_many :groups, dependent: :destroy
  has_many :group_projects, through: :groups, source: 'projects'
  has_many :projects, as: :projectable, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :destroy
  has_many :buckets, as: :attachable, :dependent => :destroy
  has_many :assets, through: :buckets
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :speaker, class_name: "User"
  belongs_to :cluster_admin, class_name: "User"

  validates_presence_of :name, :speaker_id, :cluster_admin_id
  validates_uniqueness_of :name
  
  def build_cluster_picture_bucket
    Bucket.create :attachable_id => self.id, :attachable_type => "Cluster", :name => "Cover Pictures", :name_fixed => true
  end

  def cluster_bucket
    self.buckets.find_by_name('Cover Pictures')
  end
end
