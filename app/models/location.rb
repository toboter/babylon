class Location < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :predicate_id

  geocoded_by :address
  after_validation :geocode

  belongs_to :locatable, :polymorphic => true
  belongs_to :predicate

  stampable

end
