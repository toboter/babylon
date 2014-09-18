require 'smarter_csv'

class Item < ActiveRecord::Base
  # extend FriendlyId
  # friendly_id :name, use: [:slugged, :history]
  
  attr_accessible :collection_id, :classification_id, :inventory_number, :inventory_number_index, 
            :context_id, :accession_date_text, :excavation_date_text, :creator_id, :updater_id, :title, :tag_ids, :mds_id, :dissov_id,
            :citations_attributes, :actions_attributes, :description, :slug, :properties, :excavation_id,
            :connections_attributes, :cover_asset_id

  stampable
  after_create :first_action
  serialize :properties, ActiveRecord::Coders::Hstore
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
  has_many :locations, through: :actions
  has_many :sources, through: :actions
  has_many :s_buckets, class_name: 'Bucket', through: :sources, :source => :buckets
  has_many :documents, class_name: 'Document', through: :sources, :source => :documents
  has_many :s_assets, class_name: 'Asset', through: :sources, :source => :assets

  has_many :studies, as: :studyable, dependent: :destroy
  has_many :lists, through: :studies
  has_many :projects, through: :lists

  has_many :connections, class_name: 'ItemConnection', dependent: :destroy
  has_many :inverse_connections, :class_name => "ItemConnection", :foreign_key => "inverse_item_id", dependent: :destroy

  validates :collection_id, presence: true
  validates :excavation_id, presence: true, unless: :inventory_number?
  validates :inventory_number, presence: true, unless: :excavation_id?
  validates :mds_id, :dissov_id, allow_blank: true, uniqueness: true
  validates :inventory_number, :allow_blank => true, :uniqueness => {:scope => :inventory_number_index}
  validates :inventory_number_index, :allow_blank => true, :uniqueness => {:scope => :inventory_number}
  validates :classification_id, presence: true
  # validate :validate_properties


  accepts_nested_attributes_for :citations, allow_destroy: true
  accepts_nested_attributes_for :actions, allow_destroy: true
  accepts_nested_attributes_for :connections, allow_destroy: true
  accepts_nested_attributes_for :locations, allow_destroy: true

  def buckets
    s_buckets+r_buckets
  end

  def assets
    s_assets+r_assets
  end

  def first_action
    Action.create actable_id: self.id, actable_type: 'Item', actable_date_text: Time.now, person_id: self.creator_id, predicate_id: Predicate.find_by_name('is_created_by').id
  end

  def inventory_name
    if collection && collection.name != 'none' && inventory_number
      collection.shortcut+' '+inventory_number.to_s+inventory_number_index
    end
  end

  def name
    if inventory_name
      inventory_name
    elsif excavation_id
      excavation_id.to_s
    else
      "#{id} (db_id)"
    end
  end

#  Collection.all.map{|c| c.fields.map(&:name) }.flatten.each do |key|
#    scope "has_#{key}", lambda { |value| where("properties @> hstore(?, ?)", key, value) }
#    define_method(key) do
#      property = properties && properties[key]
#      if property && property.include?('[""')
#        CollectionFieldValue.find(eval(property).compact.reject{|r| r.empty? }).map{ |cfv| cfv.field_value}
#      elsif property
#        %['select' 'radio_buttons'].include?(CollectionField.find_by_name(key).field_type) ? CollectionFieldValue.find(property).field_value : property
#      end
#    end
#  end

  def validate_properties
    collection.fields.each do |field|
      if field.required? && properties[field.name].blank?
        errors.add field.name, "must not be blank"
      end
    end
  end

  # Ransack attribute, convert & concatenat definitions
  def self.ransackable_attributes auth_object = nil
    %w(inventory_number accession_date_text title mds_id dissov_id description excavation_id) + _ransackers.keys
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
