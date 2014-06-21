class StudiesController < ApplicationController
  before_filter :authenticate_user!, :load_parent
  load_and_authorize_resource

  # GET /studies
  # GET /studies.json
  def index
    if @parent
      @studies = @parent.studies.all
    else
      @studies = Study.all
    end

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.json { render json: @studies }
    end
  end

  # GET /studies/1
  # GET /studies/1.json
  def show
    if @parent
      @study = @parent.studies.find(params[:id])
    else
      @study = Study.find(params[:id])
    end

    respond_to do |format|
      format.html { render :layout => "index_page" }# show.html.erb
      format.json { render json: @study }
    end
  end

  # GET /studies/new
  # GET /studies/new.json
  def new
    if aspect?
      @study = @parent.studies.new
      @shown_references = Project.where(show_references: true).map{|p| p.references}.flatten
      @usable_references = (@shown_references.concat(current_aspect.references)).uniq

      respond_to do |format|
        format.html { render :layout => "form_page" }# new.html.erb
        format.json { render json: @study }
      end
    else
      redirect_to @parent, notice: 'Please choose an project aspect first'
    end
  end

  # GET /studies/1/edit
  def edit
    if aspect?
      @study = @parent.studies.find(params[:id])
      if @study.list.project != current_aspect
        redirect_to [@parent, @study], alert: 'Please use the correct aspect.'
      else
        @shown_references = Project.where(show_references: true).map{|p| p.references}.flatten
        @usable_references = (@shown_references.concat(current_aspect.references)).uniq
        render :layout => "form_page"
      end
    else
      redirect_to @parent, notice: 'Please choose an project aspect first'
    end
  end

  # POST /studies
  # POST /studies.json
  def create
    @study = @parent.studies.new(params[:study])
    @shown_references = Project.where(show_references: true).map{|p| p.references}.flatten
    @usable_references = (@shown_references.concat(current_aspect.references)).uniq
    
    if @study.list.project != current_aspect
      redirect_to [@parent, @study], alert: 'Please use the correct aspect.'
    else
      respond_to do |format|
        if @study.save
          format.html { redirect_to [@study.studyable, @study], notice: 'Study was successfully added.' }
          format.json { render json: @study, status: :created, location: @study }
        else
          format.html { render action: "new" }
          format.json { render json: @study.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /studies/1
  # PUT /studies/1.json
  def update
    @study = @parent.studies.find(params[:id])

    respond_to do |format|
      if @study.update_attributes(params[:study])
        format.html { redirect_to [@study.studyable, @study], notice: 'Study was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @study.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /studies/1
  # DELETE /studies/1.json
  def destroy
    @study = @parent.studies.find(params[:id])
    @study.destroy

    respond_to do |format|
      format.html { redirect_to [@parent, :studies], notice: 'Study was successfully deleted.' }
      format.json { head :no_content }
    end
  end

private

  def load_parent
    if params[:list_id]
      @parent = List.find(params[:list_id])
    elsif params[:item_id]
      @parent = Item.find(params[:item_id])
    else
      @parent = nil
    end
  end

end
