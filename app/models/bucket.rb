class Bucket < ActiveRecord::Base
  attr_accessible :name, :creator_id, :updater_id, :asset_ids, :cover_asset_id, :name_fixed, 
  				  :attachable_id, :attachable_type

  stampable

  has_many :assets, through: :pailfuls
  has_many :pailfuls, :dependent => :destroy
  belongs_to :attachable, :polymorphic => true

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:attachable_id, :attachable_type]
  # validates limitation by person of Profile Pictures to one
  # validates :name, :exclusion => { :in => %w(profile\ pictures ..) }

  scope :with_profile_pictures, where('name = ?', 'Profile Pictures')
end
