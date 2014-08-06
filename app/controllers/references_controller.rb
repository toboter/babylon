class ReferencesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  # GET /references
  # GET /references.json
  def index
    if params[:project_id]
      @parent = Project.find(params[:project_id])
      @direct_references = @parent.references
      @indirect_references = @parent.studies.map{|r| r.references }.flatten
      @references_all = @direct_references+@indirect_references 
    elsif params[:item_id]
      @parent = Item.find(params[:item_id])
      @references_all = @parent.references
    elsif params[:study_id]
      @parent = Study.find(params[:study_id])
      @references_all = @parent.references
    elsif params[:show] == 'bibliographic'
      @references_all = Reference.joins(:projects).where(projects: {project_type: 'bibliographic', show_references: true})
    elsif params[:show] == 'archival'
      @references_all = Reference.joins(:projects).where(projects: {project_type: 'archival', show_references: true})
    elsif params[:show] == 'all'
      @references_all = Reference.scoped
    else
      @references_all = Reference.joins(:projects).where(projects: {show_references: true})
    end

    @shown_references = Project.where(show_references: true).map{|p| p.references}.flatten

    if @parent
      @references = @references_all
    else
      @q = @references_all.search(params[:q])
      @references = @q.result(distinct: true).includes(:authors, :book)
    end
    
    @references_paginated = @references.paginate(page: params[:page], per_page: 30)

    respond_to do |format|
      format.html { render layout: 'fluid' }
      format.xlsx
      format.json { render json: @references }
    end
  end

  # GET /references/1
  # GET /references/1.json
  def show
    @reference = Reference.find(params[:id])
    @shown_references = Project.where(show_references: true).map{|p| p.references}.flatten

    respond_to do |format|
      format.html { render layout: 'fluid' }# show.html.erb
      format.json { render json: @reference }
    end
  end

  # GET /references/new
  # GET /references/new.json
  def new
    if aspect?
      @reference = Reference.new(:book_id => params[:book_id])
      @reference.authorships.build

      respond_to do |format|
        format.html { render layout: 'form' }# new.html.erb
        format.json { render json: @reference }
      end
    else
      redirect_to references_path, notice: 'Choose an aspect!'
    end
  end

  # GET /references/1/edit
  def edit
    @reference = Reference.find(params[:id])

    render layout: 'form'
  end

  # POST /references
  # POST /references.json
  def create
    @reference = Reference.new(params[:reference])
    @reference.projects << current_aspect

    respond_to do |format|
      if @reference.save
        track_activity @reference
        format.html { redirect_to @reference, notice: 'Reference was successfully created.' }
        format.json { render json: @reference, status: :created, location: @reference }
      else
        format.html { render layout: 'form', action: "new" }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /references/1
  # PUT /references/1.json
  def update
    @reference = Reference.find(params[:id])
    #@reference.projects << current_aspect unless @reference.projects.exists?(current_aspect)

    respond_to do |format|
      if @reference.update_attributes(params[:reference])
        track_activity @reference
        format.html { redirect_to @reference, notice: 'Reference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render layout: 'form', action: "edit" }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /references/1
  # DELETE /references/1.json
  def destroy
    @reference = Reference.find(params[:id])
    @book = @reference.book
    @reference.destroy
    track_activity @reference

    if @book && (@book.book_type == "Monograph" || @book.book_type == "Monograph in a serial")
      @book.destroy
    end

    respond_to do |format|
      format.html { redirect_to references_url, flash: { alert: 'Reference was successfully deleted.'} }
      format.json { head :no_content }
    end
  end

end
