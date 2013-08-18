class Area < ActiveRecord::Base
  attr_accessible :name, :creator_id, :updater_id, :cluster_id

  stampable

  has_many :groups, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :destroy
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :cluster
end
