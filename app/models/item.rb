require 'smarter_csv'

class Item < ActiveRecord::Base
  # extend FriendlyId
  # friendly_id :inventory_name, use: [:slugged, :history]
  
  attr_accessible :collection_id, :classification_id, :inventory_number, :inventory_number_index, 
            :context_id, :accession_date_text, :creator_id, :updater_id, :title, :tag_ids, :mds_id, :dissov_id,
            :citations_attributes, :actions_attributes, :description, :slug, :properties, :excavation_id,
            :connections_attributes

  stampable
  
  attr_writer :accession_date_text

  serialize :properties, ActiveRecord::Coders::Hstore

  after_create :build_album_bucket
  default_scope order('inventory_number ASC, inventory_number_index ASC')

  belongs_to :collection
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :classification, class_name: 'ItemClassification', foreign_key: 'classification_id'
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :buckets, as: :attachable, dependent: :destroy
  has_many :assets, through: :buckets
  has_many :citations, as: :citable, dependent: :destroy
  has_many :references, through: :citations
  has_many :actions, as: :actable, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :destroy
  has_many :issues, as: :issuable, dependent: :destroy
  has_many :studies, as: :studyable, dependent: :destroy
  has_many :lists, through: :studies
  has_many :projects, through: :lists
  has_many :connections, class_name: 'ItemConnection', dependent: :destroy
  has_many :inverse_connections, :class_name => "ItemConnection", :foreign_key => "inverse_item_id", dependent: :destroy
  has_many :activities, as: :trackable, dependent: :destroy

  validates :inventory_number, presence: { message: "/ if there is a collection, there should also be a inventory number" }, if: :collection_id?
  validates :collection_id, presence: { message: "/ if there is a inventory number, there should also be a collection" }, if: :inventory_number?
  validates :excavation_id, presence: true, unless: :collection_id?
  validates :inventory_number, :collection_id, presence: true, unless: :excavation_id?
  validates :mds_id, :dissov_id, allow_blank: true, uniqueness: true
  validates :inventory_number, :uniqueness => {:scope => :inventory_number_index}
  validates :inventory_number_index, :allow_blank => true, :uniqueness => {:scope => :inventory_number}
  validates :classification_id, presence: true
  validate :check_accession_date_text
  # validate :validate_properties


  accepts_nested_attributes_for :citations, allow_destroy: true
  accepts_nested_attributes_for :actions, allow_destroy: true
  accepts_nested_attributes_for :connections, allow_destroy: true

  before_save :save_accession_date_text

  def inventory_name
    if collection
      collection.shortcut+' '+inventory_number.to_s+inventory_number_index
    elsif excavation_id.present?
      excavation_id.to_s
    else
      id
    end
  end

  def name
    inventory_name
  end
  
  def build_album_bucket
    Bucket.create :attachable_id => self.id, :attachable_type => "Item", :name => "#{self.name+' Album'}", :name_fixed => true
  end

  def accession_date_text
    @accession_date_text || accession_date.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end

  def save_accession_date_text
    self.accession_date = Time.zone.parse(@accession_date_text) if @accession_date_text.present?
  end

  def check_accession_date_text
    if @accession_date_text.present? && Time.zone.parse(@accession_date_text).nil?
      errors.add :accession_date_text, "cannot be parsed"
    end
  rescue ArgumentError
    errors.add :accession_date_text, "is out of range"
  end

  def validate_properties
    collection.fields.each do |field|
      if field.required? && properties[field.name].blank?
        errors.add field.name, "must not be blank"
      end
    end
  end

#  collection.fields.map{:name}.each do |key|
#    attr_accessible key
#    scope "has_#{key}", lambda { |value| where("properties @> hstore(?, ?)", key, value) }
    #
#    define_method(key) do
#      properties && properties[key]
#    end
  #
#    define_method("#{key}=") do |value|
#      self.properties = (properties || {}).merge(key => value)
#    end
#  end


  # Ransack attribute, convert & concatenat definitions
  def self.ransackable_attributes auth_object = nil
    %w(inventory_number accession_date_text title mds_id dissov_id description properties excavation_id) + _ransackers.keys
  end


  # Import csv
  def self.import(file)
    # allowed_attributes = ["collection_id", "inventory_number", "inventory_number_index", "accession_date_text", "title", "classification_id", "description", "excavation_id", 
    #  "dissov_id", "mds_id"]
    # spreadsheet = open_spreadsheet(file)
    # header = spreadsheet.row(1)
    # (2..spreadsheet.last_row).each do |i|
    #   row = Hash[[header, spreadsheet.row(i)].transpose]
    #   item = find_by_id(row["id"]) || new
    #   item.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
    #   item.save!
    # end
    records = SmarterCSV.process(file.path, {:col_sep => ";"}) do |array|
      # we're passing a block in, to process each resulting hash / =row (the block takes array of hashes)
      # when chunking is not enabled, there is only one hash in each array
      Item.create( array.first )
    end
  end
  
  # def self.open_spreadsheet(file)
  #   case File.extname(file.original_filename)
  #   when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  #   when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  #   else raise "Unknown file type: #{file.original_filename}"
  #   end
  # end


end
