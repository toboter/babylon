module ReferencesHelper

  def article_in_book(reference)
  	if reference.book
  	  book_title(reference.book, true)
  	else
  	  "not specified"
  	end
  end

  def authors_of_article(reference)
  	reference.authors.map{ |a| link_to(a.fullname,a) }.join(", ").html_safe
  end
end
