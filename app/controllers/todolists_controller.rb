class TodolistsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_project
  # GET /todolists
  # GET /todolists.json
  def index
    @todolists = @project.todolists

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.json { render json: @todolists }
    end
  end

  # GET /todolists/1
  # GET /todolists/1.json
  def show
    @todolist = @project.todolists.find(params[:id])

    respond_to do |format|
      format.html { render :layout => "show_page" }# show.html.erb
      format.json { render json: @todolist }
    end
  end

  # GET /todolists/new
  # GET /todolists/new.json
  def new
    @todolist = @project.todolists.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todolist }
    end
  end

  # GET /todolists/1/edit
  def edit
    @todolist = @project.todolists.find(params[:id])
  end

  # POST /todolists
  # POST /todolists.json
  def create
    @todolist =  @project.todolists.new(params[:todolist])

    respond_to do |format|
      if @todolist.save
        format.html { redirect_to [@todolist.project, @todolist], notice: 'Todolist was successfully created.' }
        format.json { render json: @todolist, status: :created, location: @todolist }
      else
        format.html { render action: "new" }
        format.json { render json: @todolist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todolists/1
  # PUT /todolists/1.json
  def update
    @todolist = @project.todolists.find(params[:id])

    respond_to do |format|
      if @todolist.update_attributes(params[:todolist])
        format.html { redirect_to [@todolist.project, @todolist], notice: 'Todolist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todolist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todolists/1
  # DELETE /todolists/1.json
  def destroy
    @todolist = @project.todolists.find(params[:id])
    @todolist.destroy

    respond_to do |format|
      format.html { redirect_to project_todolists_url(@project) }
      format.json { head :no_content }
    end
  end


private

  def load_project
    resource, id = request.path.split('/')[1, 2]
    @project = resource.singularize.classify.constantize.find(id)
  end
end
