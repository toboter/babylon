class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
#  def new
#    @page = Page.new(:permalink => params[:permalink])

#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @page }
#    end
#  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
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
        redirect_to root_url, notice: 'Error'
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
    
#    @page = Page.new(params[:page])
#
#    respond_to do |format|
#      if @page.save
#        format.html { redirect_to @page, notice: 'Page was successfully created.' }
#        format.json { render json: @page, status: :created, location: @page }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @page.errors, status: :unprocessable_entity }
#      end
#    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
end
