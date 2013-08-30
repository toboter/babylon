class Bucket < ActiveRecord::Base
  attr_accessible :name, :creator_id, :updater_id, :asset_ids, :cover_asset_id, :name_fixed, 
  				  :attachable_id, :attachable_type

  stampable

  has_many :assets, through: :pailfuls
  has_many :pailfuls, :dependent => :destroy
  belongs_to :attachable, :polymorphic => true
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:attachable_id, :attachable_type]
  # validates_uniqueness_of :attachable_type if :attachable_type == 'Explore'
  # validates limitation by person of Profile Pictures to one
  # validates :name, :exclusion => { :in => %w(profile\ pictures ..) }

  scope :with_profile_pictures, where('name = ?', 'Profile Pictures')

  def full_bucket_name
    if name == 'Profile Pictures'
      name+' of '+attachable.fullname
    else
      name
    end
  end
end
