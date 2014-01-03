class Reference < ActiveRecord::Base
  attr_accessible :creator_id, :updater_id, :title, :author_ids, :original_date, :alternative_author, :slug,
                  :first_page, :last_page, :book_id, :uri, :tag_ids, :babylon_specific

  stampable

  validates_presence_of :title
  #validates_presence_of :book_id, unless: :uri? Die Validierung erfolgt in dem Fall über "reject_if" im book model

  has_many :authors, :class_name => 'Person', through: :authorships, :source => :person
  has_many :authorships, :dependent => :destroy , :order => 'position'
  has_many :documents, as: :documentable, :dependent => :destroy
  has_many :buckets, as: :attachable, :dependent => :destroy
  has_many :assets, through: :buckets
  has_many :taggings, as: :taggable, :dependent => :destroy
  has_many :tags, through: :taggings
  belongs_to :book
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  has_many :comments, as: :commentable, :dependent => :destroy
  has_many :citations, :dependent => :destroy
  has_many :items, class_name: 'Citation', conditions: "citable_type = 'Item'"

  def name
    title
  end

  def self.ransackable_attributes(auth_object = nil)
    %w( title babylon_specific ) + _ransackers.keys
  end

  def entries_for_select
    authors_of_article+', '+name
  end

  def authors_of_article
    authors.present? ? authorships.map{ |a| a.person.fullname }.join(", ") : 'N.N.'
  end

end
