class BucketsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_attachable
  # GET /buckets
  # GET /buckets.json
  def index
    @buckets = @attachable.buckets

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buckets }
    end
  end

  # GET /buckets/1
  # GET /buckets/1.json
  def show
    @bucket = @attachable.buckets.find(params[:id])

    respond_to do |format|
      format.html { render :layout => "show_page" }# show.html.erb
      format.json { render json: @bucket }
    end
  end

  # GET /buckets/new
  # GET /buckets/new.json
  def new
    @bucket = @attachable.buckets.new

    respond_to do |format|
      format.html { render :layout => "form_page" }# new.html.erb
      format.json { render json: @bucket }
    end
  end

  # GET /buckets/1/edit
  def edit
    @bucket = @attachable.buckets.find(params[:id])
    render :layout => "form_page"
  end

  # POST /buckets
  # POST /buckets.json
  def create
    @bucket = @attachable.buckets.new(params[:bucket])

    respond_to do |format|
      if @bucket.save
        format.html { redirect_to [@attachable, @bucket], notice: 'Bucket was successfully created.' }
        format.json { render json: @bucket, status: :created, location: @bucket }
      else
        format.html { render action: "new" }
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
        format.html { redirect_to [@attachable, @bucket], notice: 'Bucket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bucket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buckets/1
  # DELETE /buckets/1.json
  def destroy
    @bucket = @attchable.bucket.find(params[:id])
    @bucket.destroy

    respond_to do |format|
      format.html { redirect_to buckets_url }
      format.json { head :no_content }
    end
  end

private

  def load_attachable
    resource, id = request.path.split('/')[1, 2]
    @attachable = resource.singularize.classify.constantize.find(id)
  end
end
