class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  belongs_to :targetable, polymorphic: true
  attr_accessible :action, :trackable, :user_id, :targetable, :changes_content, :user

  serialize :changes_content, Hash
end
