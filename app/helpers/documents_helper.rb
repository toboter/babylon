module DocumentsHelper

  def truncated_content(document, length=500)
  	output = truncate(document.content, length: length, seperator: ' ', omission: ' ... ')
  	output += link_to ' [more]', document_path(document) if document.content.length > length
  	output.html_safe
  end
end
