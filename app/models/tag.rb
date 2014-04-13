class Tag < ActiveRecord::Base
  attr_accessible :name, :creator_id, :updater_id, :parent_id

  has_many :taggings, dependent: :destroy

  stampable
  acts_as_tree :dependent => :destroy

  def self.tokens(query)
    tags = where("name like ?", "%#{query}%")
    if tags.empty?
      [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    else
      tags
    end
  end
  
  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end

  def self.possible_parents(tag)
    possible_parents = all-tag.self_and_descendants
  end
end
