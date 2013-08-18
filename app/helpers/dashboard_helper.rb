module DashboardHelper
  def page_doc_path_for(perma)
  	if @page = Page.find_by_permalink(perma)
  	  @doc = @page.documents.first
  	  link_to("Edit #{perma.humanize} page", [:edit, @doc.documentable, @doc]) if @doc.present?
  	else
  	  button_to("Add #{perma.humanize} page", pages_path(:permalink => perma, :type => 'doc'), class: 'button tiny')
  	end
  end
end