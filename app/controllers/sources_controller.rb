class SourcesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /sources
  # GET /sources.json
  def index
    if params[:item_id]
      @parent = Item.find(params[:item_id])
      @sources = @parent.sources
    else
      @sources = Source.scoped
    end

    @sources_all = @sources
    @q = @sources.search(params[:q])
    @sources = @q.result(distinct: true).includes(:author)

    respond_to do |format|
      format.html { render layout: 'fluid' }# index.html.erb
      format.json { render json: @sources }
    end
  end

  # GET /sources/1
  # GET /sources/1.json
  def show
    @source = Source.find(params[:id])

    respond_to do |format|
      format.html { render layout: 'fluid' }# show.html.erb
      format.json { render json: @source }
    end
  end

  # GET /sources/new
  # GET /sources/new.json
  def new
    if params[:parent]
      @parent = Source.find(params[:parent])
      @source = Source.new(parent_id: @parent.id, source_type: @parent.source_type, comment: "Original name was #{@parent.name}, original author was #{@parent.author.name}")
    else
      @source = Source.new
    end

    respond_to do |format|
      format.html { render layout: 'form' }# new.html.erb
      format.json { render json: @source }
    end
  end

  # GET /sources/1/edit
  def edit
    @source = Source.find(params[:id])
    render layout: 'form'
  end

  # POST /sources
  # POST /sources.json
  def create
    @source = Source.new(params[:source])

    respond_to do |format|
      if @source.save
        track_activity @source
        format.html { redirect_to @source, notice: 'Source was successfully created.' }
        format.json { render json: @source, status: :created, location: @source }
      else
        format.html { render layout: 'form', action: "new" }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sources/1
  # PUT /sources/1.json
  def update
    @source = Source.find(params[:id])

    respond_to do |format|
      if @source.update_attributes(params[:source])
        track_activity(@source, 'update', @source.previous_changes)
        format.html { redirect_to @source, notice: 'Source was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render layout: 'form', action: "edit" }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sources/1
  # DELETE /sources/1.json
  def destroy
    @source = Source.find(params[:id])
    @source.destroy

    respond_to do |format|
      format.html { redirect_to sources_url }
      format.json { head :no_content }
    end
  end
end
