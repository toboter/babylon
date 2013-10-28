class Tagging < ActiveRecord::Base
  attr_accessible :tag_id, :taggable_id, :taggable_type, :creator_id, :updater_id

  stampable

  belongs_to :tag
  belongs_to :taggable, :polymorphic => true
  
end
