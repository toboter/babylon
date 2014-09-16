class Project < ActiveRecord::Base
  attr_accessible :projectable_id, :projectable_type, :memberships_attributes, :creator_id, :updater_id, 
                  :show_references, :description, :featured, :studyfields_attributes, :map_type,
                  :name, :lists_attributes, :project_type, :tag_ids

  stampable

  after_create :add_first_admin, :build_project_picture_bucket

  has_many :memberships, :dependent => :destroy
  has_many :members, :class_name => 'User', through: :memberships, :source => :user
  accepts_nested_attributes_for :memberships, allow_destroy: true

  has_many :documents, as: :documentable, dependent: :destroy
  has_many :issues, as: :issuable, :dependent => :destroy
  has_many :buckets, as: :attachable, :dependent => :destroy
  has_many :assets, through: :buckets

  has_many :lists, dependent: :destroy
  accepts_nested_attributes_for :lists, allow_destroy: true
  has_many :studies, through: :lists

  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :projectable, :polymorphic => true
  has_many :todos, dependent: :destroy

  has_many :studyfields, class_name: 'ProjectStudyField'
  accepts_nested_attributes_for :studyfields, allow_destroy: true
  has_many :predicates

  has_many :project_references, :dependent => :destroy
  has_many :references, through: :project_references

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, :projectable_id, :projectable_type, presence: true
  # validates :project_type, presence: {message: 'You have to choose a project type!'}

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


  PROJECT_TYPES = %w[bibliographic research]
  MAP_TYPES = %w[Google]

end
