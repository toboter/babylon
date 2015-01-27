class ExploreController < ApplicationController
  def index
#  	@docs = Document.where(:documentable_type => 'Page')
#  	@explore = Page.find(:first, :conditions => ['permalink = ?', 'explore'])
#  	@bucket = @explore.buckets.first if @explore
#  	@cover = @bucket.cover ? @bucket.cover : @bucket.assets.last if @bucket
#  	@about = @docs.find(:first, :joins => :page, :conditions => ['pages.permalink = ?', 'about']) # @about.documents.first if @about.present?
#  	@resources = @docs.find(:first, :joins => :page, :conditions => ['pages.permalink = ?', 'resources'])
#  	@research = @docs.find(:first, :joins => :page, :conditions => ['pages.permalink = ?', 'research'])
	@about = (Snippet.select { |snip| snip.snippet_type == 'about' }).first
	@documents = Document.order('created_at DESC').limit(4)
	@about_bucket = @about.buckets.first
	@clusters = Cluster.limit(4)
	@activities = Activity.order('created_at DESC').limit(11)

	@featured = Project.where(featured: true).order('name asc')
	@featured.concat(List.where(featured: true).limit(2))

  end

end
