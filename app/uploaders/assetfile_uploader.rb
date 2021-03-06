require 'carrierwave/processing/mime_types'
# encoding: utf-8

class AssetfileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MimeTypes
  include CarrierWave::MiniMagick

  process :set_content_type
  process :save_attributes_to_model
  process :save_default_name

  def save_default_name
    model.file_name = File.basename(file.filename) if file
    model.name ||= File.basename(file.filename, '.*').titleize if file
  end

  def save_attributes_to_model
    model.content_type = file.content_type if file.content_type
    model.file_size = file.size
    model.md5hash = Digest::MD5.hexdigest(file.read) if file
  end

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  version :xlarge, :if => :is_image? do
    process :resize_to_fit => [1600, 1600]
  end
  version :large, :from_version => :xlarge, :if => :is_image? do
    process :resize_to_fit => [1280, 1280]
  end
  
  version :normal, :from_version => :large, :if => :is_image? do
    process :resize_to_fit => [430, 430]
  end
  version :small, :from_version => :normal, :if => :is_image? do
    process :resize_to_fit => [280, 280]
  end


  version :big_thumb, :from_version => :normal, :if => :is_image? do
    process :resize_to_fill => [370, 370]
  end
  version :thumb, :from_version => :big_thumb, :if => :is_image? do
    process :resize_to_fill => [200, 200]
  end
  version :mini_thumb, :from_version => :thumb, :if => :is_image? do
    process :resize_to_fill => [50, 50]
  end
  
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png tif tiff docx doc xlsx xls csv kml kmz pdf zip)
  end

  #  def default_url
  #    "#{model.class.to_s.underscore.downcase}/#{mounted_as}/missing/" + [version_name, 'missing.png'].compact.join('_')
  #  end


  def is_image? file
    file.content_type.include? 'image'
  end



  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
