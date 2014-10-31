module SnippetsHelper
  def truncated_snippet(snippet, length=300)
  	output = truncate(snippet.content, length: length, seperator: ' ', omission: ' ... ')
  	output += link_to ' [read full page]', snippet_path(snippet)
  	output += link_to ' (Edit)', edit_snippet_path(snippet) if can? :manage, snippet
  	output.html_safe
  end
end
