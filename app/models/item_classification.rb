class ItemClassification < ActiveRecord::Base
  attr_accessible :description, :name, :parent_id, :creator_id, :updater_id

  stampable
  acts_as_tree :dependent => :destroy

  has_many :items


  def self.possible_parents(classification)
    possible_parents = all-classification.self_and_descendants
  end
end
