class Reference < ActiveRecord::Base
  attr_accessible :creator_id, :updater_id, :title, :authorships_attributes, :original_date_text, :alternative_author, :slug,
                  :first_page, :last_page, :book_id, :uri, :tag_ids, :comment

  stampable

  attr_writer :original_date_text

  validates_presence_of :title

  #validates_presence_of :book_id, unless: :uri? Die Validierung erfolgt in dem Fall über "reject_if" im book model

  has_many :authorships, :dependent => :destroy
  has_many :authors, :class_name => 'PersonName', through: :authorships, :source => :person_name, :order => 'authorships.position'

  has_many :documents, as: :documentable, :dependent => :destroy
  has_many :buckets, as: :attachable, :dependent => :destroy
  has_many :assets, through: :buckets
  has_many :taggings, as: :taggable, :dependent => :destroy
  has_many :tags, through: :taggings

  has_many :project_references, :dependent => :destroy
  has_many :projects, through: :project_references

  belongs_to :book
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  has_many :issues, as: :issuable, :dependent => :destroy
  has_many :citations, :dependent => :destroy
  has_many :items, class_name: 'Citation', conditions: "citable_type = 'Item'"

  has_many :activities, as: :trackable, dependent: :destroy

  accepts_nested_attributes_for :authorships, :project_references, allow_destroy: true

  before_save :save_original_date_text

  scope :without, lambda { |ref| { :conditions => ['id not in (?)', ref.id] }}


  def name
    title
  end

  def entries_for_select
    "#{authors_of_article}, #{title} #{', '+book.serial.shortcut+' '+book.volume if book && book.serial}"
  end

  def authors_of_article
    authors.any? ? authors.map{ |a| a.name }.join(", ") : 'N.N.'
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |reference|
        csv << reference.attributes.values_at(*column_names)
      end
    end
  end

  def original_date_text
    @original_date_text || original_date.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end
  
  def save_original_date_text
    self.original_date = Time.zone.parse(@original_date_text) if @original_date_text.present?
  end

  # Ransack attribute, convert & concatenat definitions
  # def self.ransackable_attributes auth_object = nil
  #   %w(title) + _ransackers.keys
  # end

end
