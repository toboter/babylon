class Institution < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :city, :country, :creator_id, :fax, :name, :parent_id, :phone, :street, 
                  :updater_id, :uri, :zip, :slug
  friendly_id :name, use: [:slugged, :history]

  stampable
  acts_as_tree :dependent => :destroy

  has_many :affiliations
  has_many :people, through: :affiliations
  has_many :collections
  has_many :items, through: :collections

  validates_presence_of :name
  validates_associated :collections


  def self.possible_parents(inst)
    possible_parents = all-inst.self_and_descendants
  end
 
  def include_all_members
    Person.joins(:affiliations).where('affiliations.institution_id IN (?)', self.self_and_descendants)
  end

end
