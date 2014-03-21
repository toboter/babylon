class Project < ActiveRecord::Base
  attr_accessible :name, :projectable_id, :projectable_type, :memberships_attributes, :creator_id, :updater_id, :show_references

  stampable

  after_create :add_first_admin, :build_project_introduction_document

  has_many :memberships, :dependent => :destroy
  has_many :members, :class_name => 'User', through: :memberships, :source => :user
  has_many :documents, as: :documentable, dependent: :destroy
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :projectable, :polymorphic => true
  has_many :todos, dependent: :destroy

  has_many :project_references, :dependent => :destroy
  has_many :references, through: :project_references

  accepts_nested_attributes_for :memberships, allow_destroy: true

  validates_associated :memberships

  def add_first_admin
  	Membership.create :project_id => self.id, :user_id => self.creator_id, :role => "admin"
  end
  def build_project_introduction_document
    Document.create :documentable_id => self.id, :documentable_type => "Project", :document_type => "Introduction", :title => "Introduction"
  end
end
