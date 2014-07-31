class Reference < ActiveRecord::Base
  attr_accessible :creator_id, :updater_id, :title, :authorships_attributes, :original_date_text, :alternative_author, :slug,
                  :first_page, :last_page, :book_id, :uri, :tag_ids

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

  accepts_nested_attributes_for :authorships, :project_references, allow_destroy: true

  before_save :save_original_date_text

  scope :without, lambda { |ref| { :conditions => ['id not in (?)', ref.id] }}


  def name
    title
  end

  def entries_for_select
    authors_of_article+', '+title
  end

  def authors_of_article
    authors.present? ? authors.map{ |a| a.name }.join(", ") : 'N.N.'
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |reference|
        csv << reference.attributes.values_at(*column_names)
      end
    end
  end


#  def self.import(file)
#    spreadsheet = open_spreadsheet(file)
#    header = spreadsheet.row(1)
#    (2..spreadsheet.last_row).each do |i|
#      row = Hash[[header, spreadsheet.row(i)].transpose]
#      reference = find_by_id(row["id"]) || new
#      reference.attributes = row.to_hash.slice(*accessible_attributes)
#      reference
#    end
#  end
  #
#  def self.open_spreadsheet(file)
#    case File.extname(file.original_filename)
#    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
#    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
#    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
#    else raise "Unknown file type: #{file.original_filename}"
#    end
#  end

  def original_date_text
    @original_date_text || original_date.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end
  
  def save_original_date_text
    self.original_date = Time.zone.parse(@original_date_text) if @original_date_text.present?
  end

end
