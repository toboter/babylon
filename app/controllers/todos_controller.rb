class TodosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_project, except: [:show]
  load_and_authorize_resource
  
  # GET /todos
  # GET /todos.json
  def index
    if @project
      @pre_todos = @project.todos.order('completed ASC, due_to ASC')
    else
      @pre_todos = Todo.order('completed ASC, due_to ASC')
    end

    @todos = @pre_todos

    if params[:assignee]
      @todos = @todos.where(assigned_id: params[:assignee])
    end

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.json { render json: @todos }
    end
  end

  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html { render :layout => "index_page" }# show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    if @project
      @todo = @project.todos.new
    elsif aspect?
      @project = current_aspect
      @todo = current_aspect.todos.new
    end

    respond_to do |format|
      format.html { render :layout => "form_page" }# new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = @project.todos.find(params[:id])
    render :layout => "form_page"
  end

  # POST /todos
  # POST /todos.json
  def create
    if @project
      @todo =  @project.todos.new(params[:todo])
    elsif aspect?
      @project = current_aspect
      @todo = current_aspect.todos.new(params[:todo])
    end

    respond_to do |format|
      if @todo.save
        format.html { redirect_to [@project, @todo], notice: 'Todo was successfully created.' }
        format.json { render json: @todo, status: :created, location: @todo }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = @project.todos.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to [@project, @todo], notice: "Todo was successfully updated." }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todolists/1
  # DELETE /todolists/1.json
  def destroy
    @todo = @project.todos.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to [@project, :todos] }
      format.json { head :no_content }
      format.js
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

