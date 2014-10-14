class ItemClassification < ActiveRecord::Base
  attr_accessible :description, :name, :parent_id, :creator_id, :updater_id

  stampable
  acts_as_tree dependent: :destroy, order: 'name'

  has_many :items, foreign_key: 'classification_id'

  validates :description, :name, presence: true


  def self.possible_parents(classification)
    possible_parents = all-classification.self_and_descendants
  end

  def name_for_selects
  	'- ' * depth + name
  end

  def self.arrange_as_tree(options={}, hash=nil)
  	hash ||= hash_tree(options)

    arr = []
    hash.each do |node, children|
      arr << node
      arr += arrange_as_tree(options, children) unless children.nil?
    end
    arr
  end

  # Ransack attribute, convert & concatenat definitions
  def self.ransackable_attributes auth_object = nil
    %w(name description) + _ransackers.keys
  end

  def object_type
    root? ? root : self_and_ancestors.where('parent_id IS NOT ?', nil).last
  end

end
