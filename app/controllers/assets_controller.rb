class AssetsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  # GET /assets
  # GET /assets.json
  def index
    if params[:bucket_id]
      @bucket = Bucket.find(params[:bucket_id])
      @assets = @bucket.assets
    else
      @assets = Asset.all
    end

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.json { render json: @assets }
    end
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
    @asset = Asset.find(params[:id])
    @buckets = @asset.buckets

    respond_to do |format|
      format.html { render :layout => "show_page" }# show.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /assets/new
  # GET /assets/new.json
  def new
    @bucket = Bucket.find(params[:bucket_id])
    @assets_available = Asset.all-@bucket.assets

    respond_to do |format|
      format.html { render :layout => "form_page" }# new.html.erb
      format.json { render json: @bucket.assets.new }
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = Asset.find(params[:id])

    render :layout => "form_page"
  end

  # POST /assets
  # POST /assets.json
  def create
    @bucket = Bucket.find(params[:bucket_id])
    @asset = Asset.new(params[:asset])
    @asset.buckets << @bucket if @bucket

    respond_to do |format|
      if @asset.save
        format.html { redirect_to [@bucket.attachable, @bucket], notice: 'Asset was successfully created.' }
        format.json { render json: @asset, status: :created, location: @asset }
      else
        format.html { render action: "new" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.json
  def update
    @asset = Asset.find(params[:id])

    #Nur Administratoren können die Bildversionen neu erstellen. 
    #Das aber dann automatisch durch einmaliges editieren und wieder speichern.
    if can? :manage, @asset
      @asset.assetfile.recreate_versions!
    end

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to assets_url }
      format.json { head :no_content }
    end
  end
end
