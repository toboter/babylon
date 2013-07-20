class Book < ActiveRecord::Base
  attr_accessible :person_ids, :book_identifier, :book_type, :place, :publisher, :serial_id, :title, :volume, :unpublished, :year, :uri, :creator_id, :updater_id

  stampable

  validates_presence_of :book_type
  validates_presence_of :year, :unless => :unpublished == true

  has_many :articles, :class_name => 'Reference'
  has_many :people, through: :editorships
  has_many :editorships, :dependent => :destroy
  belongs_to :serial

  BOOKTYPES = %w[Monographie Sammelband Monographie\ in\ einer\ Reihe Sammelband\ in\ einer\ Reihe Band\ einer\ Zeitschrift]

  def serial_types
    if serial.serial_type == 'Zeitschrift'
      %w[Band\ einer\ Zeitschrift]
    else
      %w[Monographie\ in\ einer\ Reihe Sammelband\ in\ einer\ Reihe]
    end
  end

  def content(as_ref=false)
  	if title? && serial_id?
  	  title+', '+serial.name+' ('+volume+')'
  	elsif title?
  		title  		
	  else
	    if book_type == "Monographie" && as_ref == false
	      articles.first.title
	    elsif book_type == "Monographie in einer Reihe"
	  	  if as_ref == false
	        articles.first.title+', '+serial.name+' ('+volume+')'
	      else
	        serial.name+' ('+volume+')'
	      end
	    else
	  	  serial.name+' ('+volume+')'
	    end
	  end
  end

  def content_for_select
    editor+year+', '+content
  end

  def editor
    unless people.empty?
      people.map{ |a| a.fullname }.join(", ")+', '
    else
      if book_type == "Monographie" || book_type == "Monographie in einer Reihe"
        articles.first.people.map{ |a| a.fullname }.join(", ")+', '
      else
        ''
      end
    end
  end

  def blank_title
    if title?
      title     
    else
      if book_type == "Monographie"
        articles.first.title
      elsif book_type == "Monographie in einer Reihe"
          articles.first.title
      else
        serial.name+' ('+volume+')'
      end
    end
  end

end