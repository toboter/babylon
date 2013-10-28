class Asset < ActiveRecord::Base
  attr_accessible :assetfile, :content_type, :file_name, :file_size, :name, :parent_id, :file_author, 
    :creator_id, :updater_id, :caption, :date_taken, :latitude, :longitude, :width, :height, :camera,
    :camera_make, :flash, :focal_length, :exposure, :f_number, :iso

  stampable
  mount_uploader :assetfile, AssetfileUploader

  before_validation :update_asset_attributes, :compute_hash

  has_many :buckets, through: :pailfuls
  has_many :pailfuls, :dependent => :destroy
  has_many :comments, as: :commentable

  validates_presence_of :assetfile, :name, :content_type
  validates_uniqueness_of :md5hash, on: :create, message: "The File you are trying to upload is already in stock"

private
  
  def update_asset_attributes
    if assetfile.present? && assetfile_changed?
      self.content_type = assetfile.file.content_type
      self.file_size = assetfile.file.size
      self.file_name = assetfile.file.identifier
      date_taken = get_exif("EXIF:DateTimeOriginal") rescue nil
      date = date_taken.split(" ")[0].gsub!(/:/, '-') rescue nil
      time = date_taken.split(" ")[1] rescue nil
      self.date_taken = (date+' '+time).to_datetime rescue nil
      self.width, self.height = `identify -format "%wx%h" #{assetfile.path}`.split(/x/) rescue nil
      self.camera = get_exif("EXIF:MODEL") rescue nil
      self.camera_make = get_exif("EXIF:MAKE") rescue nil
      self.flash = get_exif("EXIF:FLASH") rescue nil
      self.focal_length = get_exif("EXIF:FOCALLENGTH") rescue nil
      self.exposure = get_exif("EXIF:EXPOSURETIME") rescue nil
      self.f_number = get_exif("EXIF:FNUMBER") rescue nil
      self.iso = get_exif("EXIF:ISOSpeedRatings") rescue nil
      extract_geolocation #funktioniert nicht mit fotos vom handy
    end
    if name.blank?
      self.name = assetfile.identifier
    end
  end

  def compute_hash
    self.md5hash = Digest::MD5.hexdigest(self.assetfile.read)
  end

  def get_exif(name)
    assetfile.manipulate! do |img|
      return img[name]
    end
  end

  #  Howto extract geodata from exif
  #  http://hasmanyfollows.com/2011/06/03/extracting-geolocation-image-data-with-carrierwave-and-rmagick-on-heroku/
  def extract_geolocation
    img_lat = get_exif('GPSLatitude')[0][1].split(', ') rescue nil
    img_lng = get_exif('GPSLongitude')[0][1].split(', ') rescue nil
 
    lat_ref = get_exif('GPSLatitudeRef')[0][1] rescue nil
    lng_ref = get_exif('GPSLongitudeRef')[0][1] rescue nil
 
    return unless img_lat && img_lng && lat_ref && lng_ref
 
    latitude = to_frac(img_lat[0]) + (to_frac(img_lat[1])/60) + (to_frac(img_lat[2])/3600)
    longitude = to_frac(img_lng[0]) + (to_frac(img_lng[1])/60) + (to_frac(img_lng[2])/3600)
 
    latitude = latitude * -1 if lat_ref == 'S'  # (N is +, S is -)
    longitude = longitude * -1 if lng_ref == 'W'   # (W is -, E is +)
 
    self.latitude = latitude
    self.longitude = longitude
  end
 
  def to_frac(strng)
    numerator, denominator = strng.split('/').map(&:to_f)
    denominator ||= 1
    numerator/denominator
  end

end
