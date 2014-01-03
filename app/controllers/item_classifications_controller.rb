class ItemClassificationsController < ApplicationController
  before_filter :authenticate_user!
  # GET /item_classifications
  # GET /item_classifications.json
  def index
    @item_classifications = ItemClassification.order(:name)

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.json { render json: @item_classifications }
    end
  end

  # GET /item_classifications/1
  # GET /item_classifications/1.json
  def show
    @item_classification = ItemClassification.find(params[:id])

    respond_to do |format|
      format.html { render :layout => "show_page" }# show.html.erb
      format.json { render json: @item_classification }
    end
  end

  # GET /item_classifications/new
  # GET /item_classifications/new.json
  def new
    @item_classification = ItemClassification.new(:parent_id => params[:parent_id])

    respond_to do |format|
      format.html { render :layout => "form_page" }# new.html.erb
      format.json { render json: @item_classification }
    end
  end

  # GET /item_classifications/1/edit
  def edit
    @item_classification = ItemClassification.find(params[:id])
    render :layout => "form_page"
  end

  # POST /item_classifications
  # POST /item_classifications.json
  def create
    @item_classification = ItemClassification.new(params[:item_classification])

    respond_to do |format|
      if @item_classification.save
        format.html { redirect_to @item_classification, notice: 'Item classification was successfully created.' }
        format.json { render json: @item_classification, status: :created, location: @item_classification }
      else
        format.html { render action: "new" }
        format.json { render json: @item_classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /item_classifications/1
  # PUT /item_classifications/1.json
  def update
    @item_classification = ItemClassification.find(params[:id])

    respond_to do |format|
      if @item_classification.update_attributes(params[:item_classification])
        format.html { redirect_to @item_classification, notice: 'Item classification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item_classification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_classifications/1
  # DELETE /item_classifications/1.json
  def destroy
    @item_classification = ItemClassification.find(params[:id])
    @item_classification.destroy

    respond_to do |format|
      format.html { redirect_to item_classifications_url }
      format.json { head :no_content }
    end
  end
end
