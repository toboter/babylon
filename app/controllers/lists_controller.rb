class ListsController < ApplicationController
  before_filter :authenticate_user!, :load_project
  load_and_authorize_resource


  # GET /lists
  # GET /lists.json
  def index
    if @project
      @lists = @project.lists
    else
      @lists = Studylist.all
    end

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.json { render json: @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @list = @project.lists.find(params[:id])

    respond_to do |format|
      format.html { render :layout => "show_page" }# show.html.erb
      format.json { render json: @list }
    end
  end

  # GET /lists/new
  # GET /lists/new.json
  def new
    @list = @project.lists.new

    respond_to do |format|
      format.html { render :layout => "form_page" }# new.html.erb
      format.json { render json: @list }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = @project.lists.find(params[:id])
    render :layout => "form_page"
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = @project.lists.new(params[:list])

    respond_to do |format|
      if @list.save
        format.html { redirect_to [@project, @list], notice: 'List was successfully created.' }
        format.json { render json: @list, status: :created, location: @list }
      else
        format.html { render action: "new" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.json
  def update
    @list = @project.lists.find(params[:id])

    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.html { redirect_to [@project, @list], notice: 'List was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list =  @project.lists.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to project_lists_url(@project) }
      format.json { head :no_content }
    end
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
