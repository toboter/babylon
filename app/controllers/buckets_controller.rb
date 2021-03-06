class BucketsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_attachable
  load_and_authorize_resource
  
  # GET /buckets
  # GET /buckets.json
  def index
    if @attachable
      @buckets = @attachable.buckets.uniq
    else
      @buckets = Bucket.all
    end

    respond_to do |format|
      format.html { render layout: 'fluid' }# index.html.erb
      format.json { render json: @buckets }
    end
  end

  # GET /buckets/1
  # GET /buckets/1.json
  def show
    @bucket = @attachable.buckets.find(params[:id])
    # @search = Asset.search(params[:q])
    @assets_available = Asset.all-@bucket.assets

    respond_to do |format|
      format.html { render layout: 'fluid' }# show.html.erb
      format.json { render json: @bucket }
    end
  end

  # GET /buckets/new
  # GET /buckets/new.json
  def new
    @bucket = @attachable.buckets.new

    respond_to do |format|
      format.html { render layout: 'form' }# new.html.erb
      format.json { render json: @bucket }
    end
  end

  # GET /buckets/1/edit
  def edit
    @bucket = @attachable.buckets.find(params[:id])
    render layout: 'form'
  end

  # POST /buckets
  # POST /buckets.json
  def create
    @bucket = @attachable.buckets.new(params[:bucket])

    respond_to do |format|
      if @bucket.save
        track_activity(@attachable, 'add', nil, @bucket)
        format.html { redirect_to [@attachable, @bucket], notice: 'Bucket was successfully created.' }
        format.json { render json: @bucket, status: :created, location: @bucket }
      else
        format.html { render layout: 'form', action: "new" }
        format.json { render json: @bucket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /buckets/1
  # PUT /buckets/1.json
  def update
    @bucket = @attachable.buckets.find(params[:id])

    respond_to do |format|
      if @bucket.update_attributes(params[:bucket])
        track_activity(@attachable, 'update', nil, @bucket)
        format.html { redirect_to [@attachable, @bucket], notice: 'Bucket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render layout: 'form', action: "edit" }
        format.json { render json: @bucket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buckets/1
  # DELETE /buckets/1.json
  def destroy
    @bucket = @attachable.buckets.find(params[:id])
    @bucket.destroy

    respond_to do |format|
      format.html { redirect_to @attachable }
      format.json { head :no_content }
    end
  end


  def set_as_cover
    @bucket = Bucket.find(params[:id])
    if params[:cover_asset_id]
      @asset = Asset.find(params[:cover_asset_id])
      @bucket.cover_asset_id = @asset.id
      if @bucket.update_attributes(params[:bucket])
        redirect_to [@bucket.attachable, @bucket], notice: 'Cover of the Bucket was successfully updated.'
      end
    else
      redirect_to :back, notice: 'No asset_id given. Error.'
    end
  end


private

  def load_attachable
    resource, id = request.path.split('/')[1, 2]
    if resource == 'modules'
      resource = 'clusters'
    elsif resource == 'blogs'
      resource = 'snippets'
    end
    @attachable = resource.singularize.classify.constantize.find(id) if id
  end

end
