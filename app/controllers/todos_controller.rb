class TodosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_project, except: :show
  load_and_authorize_resource
  
  # GET /todos
  # GET /todos.json
  def index
    @todos = @project.todos.order('completed ASC, due_to ASC')

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.json { render json: @todos }
    end
  end

  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html { render :layout => "small_sidebar_right_page" }# show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = @project.todos.new

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
    @todo =  @project.todos.new(params[:todo])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to :back, notice: 'Todo was successfully created.' }
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
        format.html { redirect_to :back, notice: "Todo was successfully updated." }
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
      format.html { redirect_to @project }
      format.json { head :no_content }
      format.js
    end
  end


private

  def load_project
    resource, id = request.path.split('/')[1, 2]
    if resource == 'projects'
      @project = resource.singularize.classify.constantize.find(id)
    else
      resource, id = request.path.split('/')[3, 4]
      @project = resource.singularize.classify.constantize.find(id)
    end
  end
end

