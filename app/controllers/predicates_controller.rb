class PredicatesController < ApplicationController
  # GET /predicates
  # GET /predicates.json
  def index
    @predicates = Predicate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @predicates }
    end
  end

  # GET /predicates/1
  # GET /predicates/1.json
  def show
    @predicate = Predicate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @predicate }
    end
  end

  # GET /predicates/new
  # GET /predicates/new.json
  def new
    @predicate = Predicate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @predicate }
    end
  end

  # GET /predicates/1/edit
  def edit
    @predicate = Predicate.find(params[:id])
  end

  # POST /predicates
  # POST /predicates.json
  def create
    @predicate = Predicate.new(params[:predicate])

    respond_to do |format|
      if @predicate.save
        format.html { redirect_to @predicate, notice: 'Predicate was successfully created.' }
        format.json { render json: @predicate, status: :created, location: @predicate }
      else
        format.html { render action: "new" }
        format.json { render json: @predicate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /predicates/1
  # PUT /predicates/1.json
  def update
    @predicate = Predicate.find(params[:id])

    respond_to do |format|
      if @predicate.update_attributes(params[:predicate])
        format.html { redirect_to @predicate, notice: 'Predicate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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
