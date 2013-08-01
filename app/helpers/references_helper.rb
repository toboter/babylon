module ReferencesHelper

  def article_in_book(reference)
  	if reference.book
  	  book_title(reference.book, true)
  	else
  	  link_to "#{reference.uri}", reference.uri
  	end
  end

  def editors(reference)
    book_edited_by(reference.book, true, true, true) if reference.book
  end

  def authors_of_article(reference)
  	reference.authors.map{ |a| link_to(a.fullname,a) }.join(", ").html_safe
  end
end
