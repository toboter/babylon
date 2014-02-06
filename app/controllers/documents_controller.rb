class DocumentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_documentable, except: [:show]
  # GET /documents
  # GET /documents.json
  def index
    if @documentable
      @documents = @documentable.documents.all
    else
      @documents = Document.where('documentable_type != ?', 'Page').order('documentable_type ASC') #ohne PAGES
    end

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html { render :layout => "show_page" }# show.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    if params[:document_type]
      @document = @documentable.documents.new(:document_type => params[:document_type], :title => params[:document_type].humanize)
    else
      @document = @documentable.documents.new
    end

    respond_to do |format|
      format.html { render :layout => "form_page" }# new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = @documentable.documents.find(params[:id])
    render :layout => "form_page"
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = @documentable.documents.new(params[:document])

    respond_to do |format|
      if @document.save
        format.html { redirect_to [@documentable, @document], notice: 'Document was successfully created.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = @documentable.documents.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to [@documentable, @document], notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = @documentable.documents.find(params[:id])
    if @document.documentable_type == 'Page'
      redirect_to :back, alert: "You can't delete documents belonging to pages!"
    else
      @document.destroy

      respond_to do |format|
        format.html { redirect_to @documentable }
        format.json { head :no_content }
      end
    end
  end

private

  def load_documentable
    resource, id = request.path.split('/')[1, 2]
    if resource == 'modules'
      resource = 'clusters'
    elsif resource == 'bibliography'
      resource = 'references'
    end
    if id == nil
      @documentable = nil
    else
      if resource == 'pages'
        @documentable = resource.singularize.classify.constantize.find_by_permalink!(id)
      else
        @documentable = resource.singularize.classify.constantize.find(id)
      end
    end
  end


end
