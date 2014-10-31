require 'smarter_csv'

class Item < ActiveRecord::Base
  # extend FriendlyId
  # friendly_id :name, use: [:slugged, :history]
  
  attr_accessible :collection_id, :classification_id, :inventory_number, :inventory_number_index, 
            :context_id, :title, :tag_ids, :mds_id, :dissov_id, :citations_attributes, :actions_attributes,
            :description, :slug, :excavation_id, :excavation_date, :excavation_place, :excavation_situation,
            :connections_attributes, :cover_asset_id, :dimensions, :condition, :material, :technique, :place, 
            :period, :excavation_prefix, :cdli_id, :weight, :joins_to_id

  stampable
  acts_as_tree parent_column_name: 'joins_to_id'
  default_scope order('inventory_number ASC, inventory_number_index ASC')

  belongs_to :collection
  belongs_to :classification, class_name: 'ItemClassification', foreign_key: 'classification_id'

  belongs_to :cover, class_name: 'Asset', foreign_key: :cover_asset_id

  has_many :issues, as: :issuable, dependent: :destroy
  has_many :activities, as: :trackable, dependent: :destroy

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :citations, as: :citable, dependent: :destroy
  has_many :references, through: :citations
  has_many :r_buckets, class_name: 'Bucket', through: :references, :source => :buckets
  has_many :r_assets, class_name: 'Asset', through: :references, :source => :assets
  # Wenn auch die reference docs hinzu genommen werden sollen, funktioniert die suche nicht mehr.
  # has_many :r_documents, class_name: 'Document', through: :references, :source => :documents

  has_many :actions, as: :actable, dependent: :destroy
  has_many :sources, through: :actions
  
  has_many :s_buckets, class_name: 'Bucket', through: :sources, :source => :buckets
  has_many :documents, class_name: 'Document', through: :sources, :source => :documents
  has_many :s_assets, class_name: 'Asset', through: :sources, :source => :assets

  has_many :studies, as: :studyable, dependent: :destroy
  has_many :lists, through: :studies
  has_many :projects, through: :lists

  has_many :connections, class_name: 'ItemConnection', dependent: :destroy
  has_many :inverse_connections, :class_name => "ItemConnection", :foreign_key => "inverse_item_id", dependent: :destroy

  validates :excavation_id, presence: true, unless: :inventory_number?
  validates :inventory_number, presence: true, unless: :excavation_id?
  validates :collection_id, presence: true, if: :inventory_number?
  validates :mds_id, :dissov_id, allow_blank: true, uniqueness: true
  validates :inventory_number, :allow_blank => true, :uniqueness => {:scope => :inventory_number_index}
  validates :inventory_number_index, :allow_blank => true, :uniqueness => {:scope => :inventory_number}
  validates :classification_id, presence: true

  accepts_nested_attributes_for :citations, allow_destroy: true
  accepts_nested_attributes_for :actions, allow_destroy: true
  accepts_nested_attributes_for :connections, allow_destroy: true

  def buckets
    s_buckets+r_buckets
  end

  def assets
    s_assets+r_assets
  end

  def inventory_name
    if collection && collection.name != 'none' && inventory_number
      "#{collection.shortcut} #{inventory_number} #{inventory_number_index}"
    end
  end

  def name
    if inventory_name
      inventory_name
    elsif excavation_id
      "#{excavation_prefix} #{excavation_id}"
    else
      "#{id} (db_id)"
    end
  end

  def self.possible_parents(obj)
    obj ? (all-obj.self_and_descendants) : all
  end

  # Ransack attribute, convert & concatenat definitions
  def self.ransackable_attributes auth_object = nil
    %w(inventory_number title mds_id dissov_id description excavation_id excavation_date excavation_place excavation_situation dimensions condition material technique place period) + _ransackers.keys
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

end
