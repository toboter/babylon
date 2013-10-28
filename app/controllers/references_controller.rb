class ReferencesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  # GET /references
  # GET /references.json
  def index
    @search = Reference.search(params[:q])
    @references = @search.result.paginate(page: params[:page], per_page: params[:per_page] ? params[:per_page] : 10) # Diese joins Authors funktioniert nicht. Doppelte AUtorenschaft wird doppelt gezählt: find(:all, :joins => :authors, :order => 'people.last_name ASC')
    @references_all = Reference.all
    # @collections = @references_all.select { |reference| reference.book.book_type == 'Sammelband' || reference.book.book_type == 'Sammelband in einer Reihe' || reference.book.book_type == 'Band einer Zeitschrift' if reference.book } 
    # @monographs = @references_all.select { |reference| reference.book.book_type == 'Monographie in einer Reihe' || reference.book.book_type == 'Monographie' if reference.book } 
    # @misc = @references_all.select { |reference| reference.book_id == nil }

    @search.build_sort if @search.sorts.empty?
    @search.build_condition if @search.conditions.empty?

    if params[:type]
      if params[:type] == 'in-collection'
        @references = @collections
      elsif params[:type] == 'as-monograph'
        @references = @monographs
      elsif params[:type] == 'misc'
        @references = @misc
      end
    end

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
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

    respond_to do |format|
      if @reference.save
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

    respond_to do |format|
      if @reference.update_attributes(params[:reference])
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

    if @book.book_type == "Monographie" || @book.book_type == "Monographie in einer Reihe"
      @book.destroy
    end

    respond_to do |format|
      format.html { redirect_to references_url, flash: { alert: 'Reference was successfully deleted.'} }
      format.json { head :no_content }
    end
  end
end
