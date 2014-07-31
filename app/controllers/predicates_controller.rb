class PredicatesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  # GET /predicates
  # GET /predicates.json
  def index
    @predicates = Predicate.order("scope_type ASC", "name ASC")

    respond_to do |format|
      format.html { render layout: 'fluid' }# index.html.erb
      format.json { render json: @predicates }
    end
  end

  # GET /predicates/1
  # GET /predicates/1.json
  def show
    @predicate = Predicate.find(params[:id])

    respond_to do |format|
      format.html { render layout: 'fluid' }# show.html.erb
      format.json { render json: @predicate }
    end
  end

  # GET /predicates/new
  # GET /predicates/new.json
  def new
    @predicate = Predicate.new

    respond_to do |format|
      format.html { render layout: 'form' }# new.html.erb
      format.json { render json: @predicate }
    end
  end

  # GET /predicates/1/edit
  def edit
    @predicate = Predicate.find(params[:id])
    render layout: 'form'
  end

  # POST /predicates
  # POST /predicates.json
  def create
    @predicate = Predicate.new(params[:predicate])
    if @predicate.scope_type == 'Attribute type' && aspect?
      @predicate.project_id = current_aspect.id
    end

    respond_to do |format|
      if @predicate.save
        format.html { redirect_to @predicate, notice: 'Predicate was successfully created.' }
        format.json { render json: @predicate, status: :created, location: @predicate }
      else
        format.html { render layout: 'form', action: "new" }
        format.json { render json: @predicate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /predicates/1
  # PUT /predicates/1.json
  def update
    @predicate = Predicate.find(params[:id])
    if @predicate.scope_type == 'Attribute type' && aspect?
      @predicate.project_id = current_aspect.id
    end

    respond_to do |format|
      if @predicate.update_attributes(params[:predicate])
        format.html { redirect_to @predicate, notice: 'Predicate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render layout: 'form', action: "edit" }
        format.json { render json: @predicate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /predicates/1
  # DELETE /predicates/1.json
  def destroy
    @predicate = Predicate.find(params[:id])
    @predicate.destroy

    respond_to do |format|
      format.html { redirect_to predicates_url }
      format.json { head :no_content }
    end
  end
end
