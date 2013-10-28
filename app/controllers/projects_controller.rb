class ProjectsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_projectable, except: [:index, :show]
  # GET /projects
  # GET /projects.json
  def index
    if params[:cluster_id]
      load_projectable
      @cluster_projects =  @projectable.projects
      @group_projects = @projectable.group_projects
      @projects = @group_projects+@cluster_projects
    elsif params[:group_id]
      load_projectable
      @projects = Group.find(params[:group_id]).projects
    else
      @projects = Project.all
    end


    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @todos = @project.todos
    @todos_by_date = @todos.group_by(&:due_to)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    respond_to do |format|
      format.html { render :layout => "show_page" }# show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = @projectable.projects.new
    # @project.memberships.build

    respond_to do |format|
      format.html { render :layout => "form_page" }# new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = @projectable.projects.find(params[:id])
    render :layout => "form_page"
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = @projectable.projects.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to [@projectable, @project], notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = @projectable.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to [@projectable, @project], notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = @projectable.projects.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

private

  def load_projectable
    resource, id = request.path.split('/')[1, 2]
    if resource == 'modules'
      resource = 'clusters'
    end
    if id
      @projectable = resource.singularize.classify.constantize.find(id)
    end
  end
end
