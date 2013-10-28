class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :parent_id, :creator_id, :updater_id, :tag_ids

  stampable
  acts_as_tree :dependent => :destroy

  belongs_to :commentable, :polymorphic => true
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  def self.possible_parents(comment)
    possible_parents = all-comment.self_and_descendants
  end

  def edited?
  	created_at != updated_at
  end

end
