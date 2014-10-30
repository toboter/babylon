class AssetsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  
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
      format.html { render layout: "fluid" }# index.html.erb
      format.json { render json: @assets }
    end
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
    @asset = Asset.find(params[:id])
    @buckets = @asset.buckets

    if params[:size] && (can? :read, @asset) && (request.path.include? 'download')
      if params[:size] == 'original'
        send_data @asset.assetfile.read, type: @asset.content_type, filename: @asset.file_name,
        :disposition => 'attachment'
      elsif params[:size] == 'xlarge' && (@asset.content_type.include? 'image')
        send_data @asset.assetfile.xlarge.read, type: @asset.content_type, filename: @asset.file_name,
        :disposition => 'attachment'
      elsif params[:size] == 'large' && (@asset.content_type.include? 'image')
        send_data @asset.assetfile.large.read, type: @asset.content_type, filename: @asset.file_name,
        :disposition => 'attachment'
      elsif params[:size] == 'normal' && (@asset.content_type.include? 'image')
        send_data @asset.assetfile.normal.read, type: @asset.content_type, filename: @asset.file_name,
        :disposition => 'attachment'
      else
        params[:size] = nil
        redirect_to @asset
      end
    else

      respond_to do |format|
        format.html { render layout: "fluid" }# show.html.erb
        format.json { render json: @asset }
      end
    end
  end

  # GET /assets/new
  # GET /assets/new.json
  def new
    @bucket = Bucket.find(params[:bucket_id])
    @asset = @bucket.assets.new

    @assets_pre = Asset.all-@bucket.assets
    # @search = Asset.search(params[:q])
    @assets_available = @assets_pre.paginate(page: params[:page], per_page: params[:per_page] ? params[:per_page] : 12)

    respond_to do |format|
      format.html { render layout: "form" }# new.html.erb
      format.json { render json: @bucket.assets.new }
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = Asset.find(params[:id])

    render :layout => "form"
  end

  # POST /assets
  # POST /assets.json
  def create
    @bucket = Bucket.find(params[:bucket_id])
    @asset = @bucket.assets.create(params[:asset])

  #  respond_to do |format|
  #    if @asset && @asset.save
  #      #format.html { redirect_to [@bucket.attachable, @bucket], notice: 'Asset was successfully created.' }
  #      format.json { render json: @asset, status: :created, location: @asset }
  #      #format.js
  #    else
  #      #format.html { render layout: "form", action: "new" }
  #      format.json { render json: @asset.errors, status: :unprocessable_entity }
  #      #format.js
  #    end
  #  end
  end

  # PUT /assets/1
  # PUT /assets/1.json
  def update
    @asset = Asset.find(params[:id])

    #Nur Administratoren können die Bildversionen neu erstellen. 
    #Das aber dann automatisch durch einmaliges editieren und wieder speichern.
    #if can? :manage, @asset
      #@asset.assetfile.recreate_versions!
    #end

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        # if fotograf do track_activity @issue, 'took a foto'
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render layout: "form", action: "edit" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  def recreate_versions
    @asset = Asset.find(params[:id])

    #Nur Administratoren können die Bildversionen neu erstellen. 
    if can? :manage, @asset
      @asset.assetfile.recreate_versions!
      redirect_to @asset, notice: 'Versions were successfully recreated.'
    else
      redirect_to @asset, notice: 'You have no permission for this action!'
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Succesfully destroyed asset.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    Asset.where(:id => params[:asset_ids]).destroy_all
    redirect_to :back, notice: 'Succesfully destroyed assets.'
  end

end
