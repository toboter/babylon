class ExploreController < ApplicationController
  def index
#  	@docs = Document.where(:documentable_type => 'Page')
#  	@explore = Page.find(:first, :conditions => ['permalink = ?', 'explore'])
#  	@bucket = @explore.buckets.first if @explore
#  	@cover = @bucket.cover ? @bucket.cover : @bucket.assets.last if @bucket
#  	@about = @docs.find(:first, :joins => :page, :conditions => ['pages.permalink = ?', 'about']) # @about.documents.first if @about.present?
#  	@resources = @docs.find(:first, :joins => :page, :conditions => ['pages.permalink = ?', 'resources'])
#  	@research = @docs.find(:first, :joins => :page, :conditions => ['pages.permalink = ?', 'research'])
	@snippets = Snippet.order('pinned DESC, created_at DESC')
	@about = (@snippets.select { |snip| snip.snippet_type == 'about' }).first
	@blogs = @snippets.limit(4).select { |snip| snip.snippet_type == 'news' }
	@about_bucket = @about.buckets.find_by_name('Explorer Pictures')
	@clusters = Cluster.limit(4)
	@activities = Activity.order('created_at DESC').limit(11)

	@featured = Project.where(featured: true)
	@featured.concat(List.where(featured: true).limit(2))

  end

end
