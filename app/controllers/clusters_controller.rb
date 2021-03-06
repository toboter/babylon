class ClustersController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  
  # GET /clusters
  # GET /clusters.json
  def index

    respond_to do |format|
      format.html { render layout: "fluid" }# index.html.erb
      format.json { render json: @clusters }
    end
  end

  # GET /clusters/1
  # GET /clusters/1.json
  def show    
    @project_members = @cluster.projects.map {|project| [project.members.map {|member| member.id }]}.flatten
    @group_project_members = @cluster.group_projects.map {|project| [project.members.map {|member| member.id }]}.flatten
    @raw_members = @project_members+@group_project_members
    @members = User.find(@raw_members)

    @projects = Project.where(id: (@cluster.project_ids+@cluster.group_project_ids))

    respond_to do |format|
      format.html { render layout: "fluid" }# show.html.erb
      format.json { render json: @cluster }
    end
  end

  # GET /clusters/new
  # GET /clusters/new.json
  def new
    @cluster = Cluster.new

    respond_to do |format|
      format.html { render layout: "form" }# new.html.erb
      format.json { render json: @cluster }
    end
  end

  # GET /clusters/1/edit
  def edit
    render layout: "form"
  end

  # POST /clusters
  # POST /clusters.json
  def create
    @cluster = Cluster.new(params[:cluster])

    respond_to do |format|
      if @cluster.save
        format.html { redirect_to @cluster, notice: 'Module was successfully created.' }
        format.json { render json: @cluster, status: :created, location: @cluster }
      else
        format.html { render layout: "form", action: "new" }
        format.json { render json: @cluster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clusters/1
  # PUT /clusters/1.json
  def update
    respond_to do |format|
      if @cluster.update_attributes(params[:cluster])
        format.html { redirect_to @cluster, notice: 'Module was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render layout: "form", action: "edit" }
        format.json { render json: @cluster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clusters/1
  # DELETE /clusters/1.json
  def destroy
    @cluster.destroy

    respond_to do |format|
      format.html { redirect_to clusters_url, alert: 'Module destroyed.' }
      format.json { head :no_content }
    end
  end
end
