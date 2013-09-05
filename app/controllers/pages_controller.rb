class PagesController < ApplicationController

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find_by_permalink!(params[:id])
    @document = Document.find(:first, :joins => :page, :conditions => ['pages.permalink = ?', @page.permalink])
    if @page.permalink == 'welcome'
      redirect_to root_url
    else
      redirect_to [@document.documentable, @document]
    end

  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(:permalink => params[:permalink])

    if @page.save && params[:type] == 'doc'
      @document = Document.new(:documentable_id => @page.id, :documentable_type => @page.class.name, :title => params[:permalink].humanize)
  
      if @document.save
        redirect_to polymorphic_url([:edit, @page, @document]), notice: 'Page was successfully created please add content.'
      else
        redirect_to root_url, notice: 'Error while creating document. Page was created. Perhaps validations failed?'
      end
    elsif @page.save && params[:type] == 'img'
      @bucket = Bucket.new(:attachable_id => @page.id, :attachable_type => @page.class.name, :name => params[:permalink], :name_fixed => true)
      if @bucket.save
        redirect_to [@page, @bucket], notice: 'Page and bucket created. Please add a picture.'
      else
        redirect_to root_url, notice: 'Error'
        # redirect_to polymorphic_url([:new, @page, :bucket]), notice: 'Error! Bucket not created.'
      end
    else
      redirect_to root_url, notice: 'Error'
    end
    
  end

end
