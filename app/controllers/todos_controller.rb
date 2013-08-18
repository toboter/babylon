class TodosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_todolist
  # GET /todos
  # GET /todos.json
  def index
    @incomplete_todos = @todolist.todos.where(completed: false).order('due_to ASC')
    @complete_todos = @todolist.todos.where(completed: true).order('due_to DESC')

    render :layout => "index_page"
#    respond_to do |format|
#      format.html { render :layout => "index_page" }# index.html.erb
#      format.json { render json: @todos }
#    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = @todolist.todos.new

#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @todo }
#    end
  end

  # GET /todos/1/edit
  def edit
    @todo = @todolist.todos.find(params[:id])
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo =  @todolist.todos.new(params[:todo])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to project_todolist_todos_url(@todolist.project, @todolist), notice: 'Todo was successfully created.' }
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
    @todo = @todolist.todos.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to project_todolist_todos_url(@todolist.project, @todolist), notice: 'Todo was successfully updated.' }
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
    @todo = @todolist.todos.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to project_todolist_todos_url(@todolist.project, @todolist) }
      format.json { head :no_content }
      format.js
    end
  end


private

  def load_todolist
    resource, id = request.path.split('/')[3, 4]
    @todolist = resource.singularize.classify.constantize.find(id)
  end
end

