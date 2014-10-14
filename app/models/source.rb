class Source < ActiveRecord::Base
  attr_accessible :author_id, :comment, :condition, :format, :institution_id, :original_date, :parent_id, :source_type, :name

  stampable

  has_many :buckets, as: :attachable, dependent: :destroy
  has_many :assets, through: :buckets
  has_many :documents, as: :documentable, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :items, through: :actions, :source => :actable, :source_type => "Item"
  has_many :issues, as: :issuable, dependent: :destroy
  has_many :activities, as: :trackable, dependent: :destroy
  
  belongs_to :author, class_name: 'Person', foreign_key: :author_id
  belongs_to :institution

  validates :source_type, :name, :author_id, presence: true
  validates :name, uniqueness: true

  acts_as_tree :dependent => :destroy

  after_create {Bucket.create(name: "#{name} files", creator_id: creator, name_fixed: true, 
    attachable: self)}
  after_update :update_bucket_name

  def update_bucket_name
    self.buckets.first.update_attributes(name: "#{name}-files") if name_changed? && self.buckets.any?
  end

  def self.possible_parents(source)
    source ? (all-source.self_and_descendants) : all
  end

  SourceTypes = %w[archival photographic]
end
