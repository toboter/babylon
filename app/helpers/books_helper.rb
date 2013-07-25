module BooksHelper

  def contentlist(book)
    content_tag :ul do  	  	
  	  book.articles.collect { |a| concat(content_tag(:li, a))}
    end
  end

  def book_edited_by(book, with_comma=false, without_no_author=false, without_author=false)
  	unless book.editors.empty?
      if with_comma == true
      	book.editors.map{ |a| link_to(a.fullname,a) }.join(", ").html_safe + ' (Hrsg.), '
      else
      	book.editors.map{ |a| link_to(a.fullname,a) }.join(", ").html_safe + ' (Hrsg.)'
      end
    else
      if book.book_type == "Monographie" || book.book_type == "Monographie in einer Reihe"
      	if without_author == true
      	  ''
      	else
          if with_comma == true
            book.articles.first.authors.map{ |a| link_to(a.fullname,a) }.join(", ").html_safe + ', '
          else
            book.articles.first.authors.map{ |a| link_to(a.fullname,a) }.join(", ").html_safe
          end
        end
      else
      	if without_no_author == true
      	  ''
      	else
          'Kein Autor'
        end
      end
    end
  end

  def book_title(book, without_article_title=false)
  	if book.title && book.serial.blank?
  	  if book.book_type == "Monographie"
  	    link_to "#{book.articles.first.title}", book
  	  else
  	    link_to "#{book.title}", book
  	  end
  	elsif book.title && book.serial
	  if book.book_type == "Monographie in einer Reihe"
	  	if without_article_title == true
	      (link_to "#{book.serial.name}", book.serial)+' ('+(link_to "#{book.volume}", book)+')'
	    else
	  	  (link_to "#{book.articles.first.title}", book.articles.first)+', '+(link_to "#{book.serial.name}", book.serial)+' ('+(link_to "#{book.volume}", book)+')'
	    end
	  else
	  	if book.book_type == "Band einer Reihe" || book.book_type == "Sammelband in einer Reihe"
	  	  (link_to "#{book.title}", book)+', '+(link_to "#{book.serial.name}", book.serial)+' ('+(link_to "#{book.volume}", book)+')'
	  	else
	  	  (link_to "#{book.serial.name}", book.serial)+' ('+(link_to "#{book.volume}", book)+')'
	  	end
	  end
	end
  end

  def  book_short_title(book)
  	if book.title && book.serial.blank?
  	  if book.book_type == "Monographie"
  	    book.articles.first.title
  	  else
  	   book.title
  	  end
  	elsif book.title && book.serial
	  if book.book_type == "Monographie in einer Reihe"
	  	  book.articles.first.title+', '+book.serial.name+' ('+book.volume+')'
	  else
	  	if book.book_type == "Band einer Reihe" || book.book_type == "Sammelband in einer Reihe"
	  	  book.title+', '+book.serial.name+' ('+book.volume+')'
	  	else
	  	  book.serial.name+' ('+book.volume+')'
	  	end
	  end
	end
  end

  def  book_short_edited_by(book)
  	unless book.editors.empty?
      	book.editors.map{ |a| a.fullname }.join(", ").html_safe + ' (Hrsg.), '
    else
      if book.book_type == "Monographie" || book.book_type == "Monographie in einer Reihe"
          book.articles.first.authors.map{ |a| link_to(a.fullname,a) }.join(", ").html_safe + ', '
      else
      	  ''
      end
    end  	
  end

  def entries_for_select(book)
  	book_short_edited_by(book)+book.year+', '+book_short_title(book)
  end

end


