class ReferencesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  # GET /references
  # GET /references.json
  def index
    if params[:project_id]
      @parent = Project.find(params[:project_id])
      @references_all = @parent.references 
    elsif params[:item_id]
      @parent = Item.find(params[:item_id])
      @references_all = @parent.references
    elsif params[:show] == 'all'
      @references_all = Reference.all
    else
      @references_all = Reference.joins(:projects).where('show_references = ?', true)
    end

    @references = @references_all.paginate(page: params[:page], per_page: params[:per_page] ? params[:per_page] : 10)

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.csv { send_data @references_unpaginated.to_csv }
      format.xls # { send_data @references.to_csv(col_sep: "\t") }
      format.json { render json: @reference }
    end
  end

  # GET /references/1
  # GET /references/1.json
  def show
    @reference = Reference.find(params[:id])

    respond_to do |format|
      format.html { render :layout => "show_page" }# show.html.erb
      format.json { render json: @reference }
    end
  end

  # GET /references/new
  # GET /references/new.json
  def new
    @reference = Reference.new(:book_id => params[:book_id])
    @reference.authorships.build

    respond_to do |format|
      format.html { render :layout => "form_page" }# new.html.erb
      format.json { render json: @reference }
    end
  end

  # GET /references/1/edit
  def edit
    @reference = Reference.find(params[:id])

    render :layout => "form_page"
  end

  # POST /references
  # POST /references.json
  def create
    @reference = Reference.new(params[:reference])
    @reference.projects << current_aspect

    respond_to do |format|
      if @reference.save
        track_activity @reference
        format.html { redirect_to @reference, notice: 'Reference was successfully created.' }
        format.json { render json: @reference, status: :created, location: @reference }
      else
        format.html { render action: "new" }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /references/1
  # PUT /references/1.json
  def update
    @reference = Reference.find(params[:id])
    #@reference.projects << current_aspect unless @reference.projects.exists?(current_aspect)

    respond_to do |format|
      if @reference.update_attributes(params[:reference])
        track_activity @reference
        format.html { redirect_to @reference, notice: 'Reference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /references/1
  # DELETE /references/1.json
  def destroy
    @reference = Reference.find(params[:id])
    @book = @reference.book
    @reference.destroy
    track_activity @reference

    if @book && (@book.book_type == "Monograph" || @book.book_type == "Monograph in a serial")
      @book.destroy
    end

    respond_to do |format|
      format.html { redirect_to references_url, flash: { alert: 'Reference was successfully deleted.'} }
      format.json { head :no_content }
    end
  end

end
