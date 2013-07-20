module BooksHelper

  def contentlist(book)
    content_tag :ul do  	  	
  	  book.articles.collect { |a| concat(content_tag(:li, a))}
    end
  end
end
