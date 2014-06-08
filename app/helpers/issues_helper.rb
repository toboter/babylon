module IssuesHelper

  def issue_comment_popover_presenter(issue)
  	issue.comments.first.content
  end

  def issue_issuable_popover_presenter(issue)
  	issue.issuable.class.name
  end

end
