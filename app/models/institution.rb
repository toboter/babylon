class Institution < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :city, :country, :creator_id, :fax, :name, :parent_id, :phone, :street, 
                  :updater_id, :uri, :zip, :slug, :collections_attributes
  friendly_id :name, use: [:slugged, :history]

  stampable
  acts_as_tree :dependent => :destroy

  has_many :people
  has_many :collections
  has_many :items, through: :collections

  validates_presence_of :name
  validates_associated :collections

  accepts_nested_attributes_for :collections, allow_destroy: false

  def self.possible_parents(inst)
    possible_parents = all-inst.self_and_descendants
  end
 
  def include_all_members
    Person.where('institution_id IN (?)', self.self_and_descendants)
  end

end
