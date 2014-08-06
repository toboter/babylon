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

  def link_to_authors_of_article(reference)
  	reference.authors.present? ? reference.authorships.map{ |a| link_to((a.person_name.name),a.person_name.person) }.join(", ").html_safe : 'N.N.'
  end

  def full_reference(reference)
    article = "#{reference.authors_of_article}, #{reference.title}" if reference
    book = "in: #{book_entries_for_select(reference.book)}" if reference.book
    "#{article}, #{book}"
  end
end
