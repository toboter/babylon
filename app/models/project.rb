class Project < ActiveRecord::Base
  attr_accessible :name, :projectable_id, :projectable_type, :memberships_attributes, :creator_id, :updater_id, 
                  :show_references, :description, :featured

  stampable

  after_create :add_first_admin, :build_project_picture_bucket

  has_many :memberships, :dependent => :destroy
  has_many :members, :class_name => 'User', through: :memberships, :source => :user
  has_many :documents, as: :documentable, dependent: :destroy
  has_many :issues, as: :issuable, :dependent => :destroy
  has_many :buckets, as: :attachable, :dependent => :destroy
  has_many :assets, through: :buckets
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :projectable, :polymorphic => true
  has_many :todos, dependent: :destroy

  has_many :studyassignments, :dependent => :destroy
  has_many :items, through: :studyassignments

  has_many :project_references, :dependent => :destroy
  has_many :references, through: :project_references

  accepts_nested_attributes_for :memberships, allow_destroy: true

  validates_associated :memberships
  validates_presence_of :name, :projectable_id, :projectable_type

  scope :with_user, lambda{|user| user ? {joins: :members, :conditions => ["user_id = ?", user]} : {}}

  def add_first_admin
  	Membership.create :project_id => self.id, :user_id => self.creator_id, :role => "admin"
  end

  def build_project_picture_bucket
    Bucket.create :attachable_id => self.id, :attachable_type => "Project", :name => "Cover Pictures", :name_fixed => true
  end

  def project_bucket
    self.buckets.find_by_name('Cover Pictures')
  end

end
