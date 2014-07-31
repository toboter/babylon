class CollectionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_institution
  load_and_authorize_resource
  
  # GET /collections
  # GET /collections.json
  def index
    @collections = @institution.collections.order(:name)

    respond_to do |format|
      format.html { render layout: 'fluid' }# index.html.erb
      format.json { render json: @collections }
    end
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
    @collection =  @institution.collections.find(params[:id])

    respond_to do |format|
      format.html { render layout: 'fluid' }# show.html.erb
      format.json { render json: @collection }
    end
  end

  # GET /collections/new
  # GET /collections/new.json
  def new
    @collection =  @institution.collections.new

    respond_to do |format|
      format.html { render layout: 'form' }# new.html.erb
      format.json { render json: @collection }
    end
  end

  # GET /collections/1/edit
  def edit
    @collection =  @institution.collections.find(params[:id])
    render layout: 'form'
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection =  @institution.collections.new(params[:collection])

    respond_to do |format|
      if @collection.save
        format.html { redirect_to [@collection.institution, @collection], notice: 'Collection was successfully created.' }
        format.json { render json: @collection, status: :created, location: @collection }
      else
        format.html { render layout: 'form', action: "new" }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /collections/1
  # PUT /collections/1.json
  def update
    @collection =  @institution.collections.find(params[:id])

    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        format.html { redirect_to [@collection.institution, @collection], notice: 'Collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render layout: 'form', action: "edit" }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection =  @institution.collections.find(params[:id])
    @collection.destroy

    respond_to do |format|
      format.html { redirect_to institution_collections_url(@institution) }
      format.json { head :no_content }
    end
  end


private

  def load_institution
    resource, id = request.path.split('/')[1, 2]
    @institution = resource.singularize.classify.constantize.find(id)
  end
end
