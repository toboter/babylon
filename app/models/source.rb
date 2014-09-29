class Source < ActiveRecord::Base
  attr_accessible :author_id, :comment, :condition, :format, :institution_id, :original_date, :parent_id, :source_type, :name

  stampable

  has_many :buckets, as: :attachable, dependent: :destroy
  has_many :assets, through: :buckets
  has_many :documents, as: :documentable, dependent: :destroy
  has_many :source_assignments, dependent: :destroy
  has_many :actions, through: :source_assignments
  has_many :items, through: :actions, :source => :actable, :source_type => "Item"
  has_many :issues, as: :issuable, dependent: :destroy
  has_many :activities, as: :trackable, dependent: :destroy
  
  belongs_to :author, class_name: 'Person', foreign_key: :author_id
  belongs_to :institution

  validates :source_type, :name, presence: true

  acts_as_tree :dependent => :destroy

  def self.possible_parents(source)
    source ? (all-source.self_and_descendants) : all
  end

  SourceTypes = %w[archival photographic]
end
