class ExploreController < ApplicationController
  def index
  	@docs = Document.where(:documentable_type => 'Page')
  	@welcome = Page.find(:first, :conditions => ['permalink = ?', 'welcome'])
  	@bucket = @welcome.buckets.first if @welcome.present?
  	@cover = @bucket.cover_asset_id ? Asset.has_cover_id(@bucket.cover_asset_id) : @bucket.assets.last if @bucket.present?
  	@about = @docs.find(:first, :joins => :page, :conditions => ['pages.permalink = ?', 'about']) # @about.documents.first if @about.present?
  	@resources = @docs.find(:first, :joins => :page, :conditions => ['pages.permalink = ?', 'resources'])
  	@research = @docs.find(:first, :joins => :page, :conditions => ['pages.permalink = ?', 'research'])
  end

end
