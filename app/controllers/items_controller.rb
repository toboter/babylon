class ItemsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_project, except: [:show]
  load_and_authorize_resource

  # GET /items
  # GET /items.json
  def index
    if @project
      @items = @project.items
    else
      @items = Item.scoped
    end

    @q = @items.search(params[:q])
    @items = @q.result(distinct: true).includes(:collection) #.includes(:authors, :book)
    @q.build_condition if @q.conditions.empty?
    @q.build_sort if @q.sorts.empty?

    @items_paginated = @items.paginate(page: params[:page], per_page: 30)

    respond_to do |format|
      format.html { render layout: 'fluid' }# index.html.erb
      format.xlsx
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
    @images = @item.assets.where('content_type LIKE ?', '%image%')

    respond_to do |format|
      format.html { render layout: 'fluid' }# show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new(:collection_id => params[:collection_id])

    respond_to do |format|
      format.html { render layout: 'form' }# new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])

    render layout: 'form'
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        track_activity @item
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render layout: 'form', action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        track_activity @item
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render layout: 'form', action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    track_activity @item

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  def import
    Item.import(params[:file])
      redirect_to items_url, alert: 'Items imported -  or not. There is no validation. Please check if items are imported. 
        If not, there may be duplicates in inventory_number, excavation_id, mds_id or dissov_id'
  end

private

  def load_project
    if params[:project_id]
      @project = Project.find(params[:project_id])
    else
      @project = nil
    end
  end


end
