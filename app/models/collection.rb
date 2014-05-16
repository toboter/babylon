class Collection < ActiveRecord::Base
  attr_accessible :name, :shortcut, :creator_id, :updater_id, :institution_id, :fields_attributes

  stampable

  belongs_to :institution
  has_many :items
  has_many :fields, class_name: 'CollectionField'

  validates_presence_of :name, :shortcut
  validates_uniqueness_of :name, :shortcut
  
  accepts_nested_attributes_for :fields, allow_destroy: true
end
