class Document < ActiveRecord::Base
  attr_accessible :content, :document_type, :documentable_id, :documentable_type, :title, 
  				  :creator_id, :updater_id, :abstract, :tag_ids, :documentfile, :remote_documentfile_url,
            :documentfile_content_type, :documentfile_name, :documentfile_upload_date, :documentfile_size, :documentfile_md5hash

  stampable
  mount_uploader :documentfile, DocumentfileUploader

  before_validation :update_documentfile_attributes

  belongs_to :documentable, :polymorphic => true
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  has_many :issues, as: :issuable, :dependent => :destroy
  has_many :taggings, as: :taggable, :dependent => :destroy
  has_many :tags, through: :taggings

  DOKUMENTTYPES = %w[Introduction]

  validates_presence_of :title, :unless => :document_type?
  validates_presence_of :abstract, :unless => :content?
  validates_uniqueness_of :document_type, :allow_blank => true, :scope => [:documentable_id, :documentable_type]
  validates_uniqueness_of :title, :scope => [:documentable_id, :documentable_type]

  def name
    title ? title : document_type
  end

  def self.doctype(type)
    where(:document_type => type).first
  end

  scope :without_document_type, where('document_type NOT IN (?)', Document::DOKUMENTTYPES)
  scope :created_by, lambda { |c| where("creator_id = ?", c.id) }

  def title_readonly?
    (document_type == 'Introduction')
  end

  def self.ransackable_attributes auth_object = nil
    %w(content title abstract) + _ransackers.keys
  end

private

  def update_documentfile_attributes
    if documentfile.present? && documentfile_changed?
      self.documentfile_md5hash = Digest::MD5.hexdigest(self.documentfile.read)
      self.documentfile_content_type = documentfile.file.content_type
      self.documentfile_size = documentfile.file.size
      self.documentfile_name = File.basename(documentfile.path || documentfile.filename)
      self.documentfile_upload_date = Time.now if documentfile_changed? #FEHLER Form ist offenbar immer dirty. Wird daher immer geupdated. nach md5hash vorzugehen ist scheinbar zu grob.
    end
  end 
end
