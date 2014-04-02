class Issue < ActiveRecord::Base
  attr_accessible :assigned_id, :closed, :issuable_id, :issuable_type, :name, 
  				  :creator_id, :updater_id, :comments_attributes

  stampable
  acts_as_sequenced scope: [:issuable_id, :issuable_type]

  LABELS = %w{Administrative ...}

  belongs_to :issuable, :polymorphic => true
  has_many :comments, dependent: :destroy

  belongs_to :assigned, class_name: "User"
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"

  validates :name, :issuable_id, :issuable_type, presence: true

  accepts_nested_attributes_for :comments, allow_destroy: true


  def participants
  	participants = comments.map(&:creator)
  	participants << self.assigned if assigned
  	participants.uniq
  end

end
