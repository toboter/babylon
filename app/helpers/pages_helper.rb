module PagesHelper
  def page_doc_path_for(perma)
  	if @page = Page.find_by_permalink(perma)
  	  @doc = @page.documents.first
  	  (link_to("Edit #{perma.humanize} page", [:edit, @doc.documentable, @doc]) if @doc.present?)# +
  	  #(link_to 'Destroy', @page, :confirm => 'Are you sure?', :method => :delete, class: 'pull-right')
  	else
  	  button_to("Add #{perma.humanize} page", pages_path(:permalink => perma, :type => 'doc'), class: 'btn btn-mini')
  	end
  end
end
