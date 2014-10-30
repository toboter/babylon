module IssuesHelper

  def issue_comment_popover_presenter(issue)
  	# content_tag(:ul) { issue.comments.map {|c| content_tag(:li) { "#{c.content} (written by #{c.creator.available_name} #{time_ago_in_words(c.created_at)} ago)" }}.reduce(:<<) } if issue.comments.any?
  	content_tag :ul do
  	  issue.comments.order('created_at DESC').map{|c| content_tag :li, "#{c.content}"+content_tag(:span, " (written by #{c.creator.available_name}, #{time_ago_in_words(c.created_at)} ago)", class: 'muted') }.reduce(:<<)
  	end if issue.comments.any?
  end

  def issue_issuable_popover_presenter(issue)
  	issue.issuable.class.name
  end

end
