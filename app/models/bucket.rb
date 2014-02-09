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

  def full_bucket_name
    if name == 'Profile Pictures' && attachable_type == 'Person'
      name+' of '+attachable.fullname
    elsif name == 'explore' && attachable_type == 'Page'
      'Banner pictures'
    else
      name
    end
  end

  def profile_picture_bucket?
    name == 'Profile Pictures'
  end

  def cover
    if cover_asset_id
      cover = assets.find_by_id(cover_asset_id)
    else
      cover = assets.last
    end
  end

end
