class ProjectsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_projectable, except: :show
  load_and_authorize_resource
  
  # GET /projects
  # GET /projects.json
  def index
    if params[:cluster_id]
      @cluster_projects =  @projectable.projects
      @group_projects = @projectable.group_projects
      @all_projects = Project.where(id: (@projectable.project_ids+@projectable.group_project_ids))

      if params[:state] == 'group'
        @projects = @group_projects
      elsif params[:state] == 'module'
        @projects = @projectable.projects
      else
        @projects = @all_projects
      end
    elsif params[:group_id]
      @projects = Group.find(params[:group_id]).projects
      @all_projects = @projects
    end

    @current_user_projects = @projects.with_user(current_user)
    if params[:ufilter] == 'you-are-in'
      @projects = @current_user_projects
    end

    respond_to do |format|
      format.html { render layout: 'fluid' }# index.html.erb
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
    @shown_references = Project.where(show_references: true).map{|p| p.references}.flatten

    @hash = Gmaps4rails.build_markers(@project.lists.where("lists.latitude IS NOT NULL")) do |list, marker|
      marker.lat list.latitude
      marker.lng list.longitude
      marker.infowindow "#{list.name}: #{list.description}. 
      <a href='#{url_for([list.project, list])}'>...more</a>"
      marker.json({ title: list.name })
    end

    respond_to do |format|
      format.html { render layout: 'fluid' }# show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = @projectable.projects.new
    @users = User.without_user(current_user)
    # @project.memberships.build

    respond_to do |format|
      format.html { render layout: 'form' }# new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = @projectable.projects.find(params[:id])
    @users = User.all
    render layout: 'form'
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = @projectable.projects.new(params[:project])

    respond_to do |format|
      if @project.save
        track_activity @project
        format.html { redirect_to [@projectable, @project], notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render layout: 'form', action: "new" }
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
        track_activity @project
        format.html { redirect_to [@projectable, @project], notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render layout: 'form', action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = @projectable.projects.find(params[:id])
    @project.destroy
    track_activity @project

    respond_to do |format|
      format.html { redirect_to [@projectable, :projects] }
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
