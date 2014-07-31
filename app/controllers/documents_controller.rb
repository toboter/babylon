class DocumentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_documentable, except: [:show, :download]
  load_and_authorize_resource
  
  # GET /documents
  # GET /documents.json
  def index
    if @documentable
      @documents = @documentable.documents
      @all_documents = @documents
      @current_user_documents = @documents.created_by(current_user)
      @need_review_documents = @documents.joins(:issues).where(issues: {assigned_id: current_user.id, closed: false})

      if params[:ufilter] == 'created_by'
        @documents = @current_user_documents
      end
      if params[:ufilter] == 'need_review'
        @documents = @need_review_documents
      end
    else
      @documents = Document.all
      @all_documents = @documents
      @current_user_documents = Document.created_by(current_user)
      @need_review_documents = Document.joins(:issues).where(issues: {assigned_id: current_user.id})

      if params[:ufilter] == 'created_by'
        @documents = @current_user_documents
      end
      if params[:ufilter] == 'need_review'
        @documents = @need_review_documents
      end
    end



    respond_to do |format|
      format.html { render layout: 'fluid' }# index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html { render layout: 'fluid' }# show.html.erb
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
      format.html { render layout: 'form' }# new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = @documentable.documents.find(params[:id])
    render layout: 'form'
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = @documentable.documents.new(params[:document])

    respond_to do |format|
      if @document.save
        track_activity @document
        format.html { redirect_to [@documentable, @document], notice: 'Document was successfully created.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render layout: 'form', action: "new" }
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
        track_activity @document
        format.html { redirect_to [@documentable, @document], notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render layout: 'form', action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = @documentable.documents.find(params[:id])
    @document.destroy
    track_activity @document

    respond_to do |format|
      format.html { redirect_to @documentable }
      format.json { head :no_content }
    end
  end

  def download
    @document = Document.find(params[:id])
    send_data @document.documentfile.read, type: @document.documentfile_content_type, filename: @document.documentfile_name, :disposition => 'attachment'
  end

private

  def load_documentable
    resource, id = request.path.split('/')[1, 2]
    if resource == 'modules'
      resource = 'clusters'
    elsif resource == 'announcements'
      resource = 'snippets'
    end
    if id == nil
      @documentable = nil
    else
      @documentable = resource.singularize.classify.constantize.find(id)
    end
  end


end
