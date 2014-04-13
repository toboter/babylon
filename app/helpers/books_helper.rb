module BooksHelper

  def contentlist(book)
    content_tag :ul do  	  	
  	  book.articles.collect { |a| concat(content_tag(:li, a))}
    end
  end

  def book_edited_by(book, with_comma=false, without_no_author=false, without_author=false)
  	if book.editors.any?
      if with_comma == true
      	(book.editorships.map{ |a| link_to(a.person_name.name,a.person_name.person) }.join(", ").html_safe) + ' (Hrsg.), '
      else
      	(book.editorships.map{ |a| link_to(a.person_name.name,a.person_name.person) }.join(", ").html_safe) + ' (Hrsg.)'
      end
    else
      if (book.book_type == "Monograph" || book.book_type == "Monograph in a serial") && book.articles.any?
      	if without_author == true
      	  ''
      	else
          if with_comma == true
            book.articles.first.authorships.map{ |a| link_to(a.person_name.name,a.person_name.person) }.join(", ").html_safe + ', '
          else
            book.articles.first.authorships.map{ |a| link_to(a.person_name.name,a.person_name.person) }.join(", ").html_safe
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
  	  if book.book_type == "Monograph" && book.articles.any?
  	    link_to "#{book.articles.first.title}", book
  	  else
  	    link_to "#{book.title}", book
  	  end
  	elsif book.title && book.serial
	    if book.book_type == "Monograph in a serial" && book.articles.any?
	  	  if without_article_title == true
	        (link_to "#{book.serial.name}", book.serial)+' ('+(link_to "#{book.volume}", book)+')'
	      else
	  	    (link_to "#{book.articles.first.title}", book.articles.first)+', '+(link_to "#{book.serial.name}", book.serial)+' ('+(link_to "#{book.volume}", book)+')'
	      end
	    else
	  	  if book.book_type == "Collection in a serial" # || book.book_type == "Band einer Reihe"
	  	    (link_to "#{book.title}", book)+', '+(link_to "#{book.serial.name}", book.serial)+' ('+(link_to "#{book.volume}", book)+')'
	  	  else
	  	    (link_to "#{book.serial.name}", book.serial) +' ('+(link_to "#{book.volume}", book)+')'
	  	  end
	    end
	  end
  end

  def book_short_title(book, abbr=false)
  	if book.title && book.serial.blank?
  	  if book.book_type == "Monograph" && book.articles.any?
  	    book.articles.first.title
  	  else
  	   book.title
  	  end
  	elsif book.title && book.serial
	  if book.book_type == "Monograph in a serial" && book.articles.any?
	  	  book.articles.first.title+', '+ (abbr == false ? book.serial.name : book.serial.shortcut) +' ('+book.volume+')'
	  else
	  	if book.book_type == "Collection in a serial" # || book.book_type == "Band einer Reihe"
	  	  book.title+', '+ (abbr == false ? book.serial.name : book.serial.shortcut) +' ('+book.volume+')'
	  	else
	  	  (abbr == false ? book.serial.name : book.serial.shortcut) +' ('+book.volume+')'
	  	end
	  end
	end
  end

  def  book_short_edited_by(book)
  	if book.editors.any?
      	book.editorships.map{ |a| a.person_name.name }.join(", ").html_safe + ' (Hrsg.), '
    else
      if (book.book_type == "Monograph" || book.book_type == "Monograph in a serial") && book.articles.any?
          book.articles.first.authorships.map{ |a| a.person_name.name }.join(", ").html_safe + ', '
      else
      	  ''
      end
    end  	
  end

  def entries_for_select(book)
  	book_short_edited_by(book) + book.year + ', ' + book_short_title(book)
  end

end


