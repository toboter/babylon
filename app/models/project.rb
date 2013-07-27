class Project < ActiveRecord::Base
  attr_accessible :name, :group_id, :memberships_attributes, :creator_id, :updater_id

  stampable

  after_create :add_first_admin
  
  belongs_to :group
  has_many :memberships, :dependent => :destroy
  has_many :members, :class_name => 'User', through: :memberships, :source => :user

  accepts_nested_attributes_for :memberships, allow_destroy: true


  def add_first_admin
  	Membership.create :project_id => self.id, :user_id => self.creator_id, :role => "admin"
  end

end
