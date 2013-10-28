class Reference < ActiveRecord::Base
  attr_accessible :creator_id, :updater_id, :title, :author_ids, :original_date, :alternative_author, :slug,
                  :first_page, :last_page, :book_id, :uri, :tag_ids

  stampable

  validates_presence_of :title
  #validates_presence_of :book_id, unless: :uri? Die Validierung erfolgt in dem Fall über "reject_if" im book model

  has_many :authors, :class_name => 'Person', through: :authorships, :source => :person
  has_many :authorships, :dependent => :destroy , :order => 'position'
  has_many :documents, as: :documentable
  has_many :buckets, as: :attachable
  has_many :assets, through: :buckets
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  belongs_to :book
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  has_many :comments, as: :commentable

  def name
    title
  end

  def self.ransackable_attributes(auth_object = nil)
    %w( title ) + _ransackers.keys
  end

end
