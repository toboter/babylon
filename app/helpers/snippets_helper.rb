module SnippetsHelper
  def truncated_description(snippet, length=200)
  	output = truncate(snippet.description, length: length, seperator: ' ', omission: ' ... ')
  	output += link_to ' [more]', snippet_path(snippet) if snippet.description.length > length
  	output += link_to ' (Edit)', edit_snippet_path(snippet) if can? :edit, snippet
  	output.html_safe
  end
end
