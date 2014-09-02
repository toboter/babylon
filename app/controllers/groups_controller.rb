class GroupsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_cluster, except: [:index, :show]
  authorize_resource
  
  # GET /groups
  # GET /groups.json
  def index
    if params[:cluster_id]
      load_cluster
      @groups = @cluster.groups
    else
      @groups = Group.all
    end

    respond_to do |format|
      format.html { render layout: 'fluid' }# index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    @group_members = @group.projects.map {|project| [project.members.map {|member| member.id }]}.flatten
    @members = User.find(@group_members)

    respond_to do |format|
      format.html { render layout: 'fluid' }# show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = @cluster.groups.new

    respond_to do |format|
      format.html { render layout: 'form' }# new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = @cluster.groups.find(params[:id])
    render layout: 'form'
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = @cluster.groups.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to [@group.cluster, @group], notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render layout: 'form', action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = @cluster.groups.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to [@group.cluster, @group], notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render layout: 'form', action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = @cluster.groups.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to @cluster, alert: 'Group destroyed.' }
      format.json { head :no_content }
    end
  end


private

  def load_cluster
    if params[:cluster_id]
      @cluster = Cluster.find(params[:cluster_id])
    else
      @cluster = nil
    end
  end
end
