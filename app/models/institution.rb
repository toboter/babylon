class Institution < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :city, :country, :creator_id, :fax, :name, :parent_id, :phone, :street, :updater_id, :uri, :zip, :slug
  friendly_id :name, use: [:slugged, :history]

  stampable
  acts_as_tree :dependent => :destroy

  has_many :people

  def self.possible_parents(inst)
    possible_parents = all-inst.self_and_descendants
  end
 
end
