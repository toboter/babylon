class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_commentable
  load_and_authorize_resource

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = @commentable.comments.new(:parent_id => params[:parent_id])

    respond_to do |format|
      format.html { render :layout => "form_page" }# new.html.erb
      format.json { render json: @comment }
      format.js
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = @commentable.comments.find(params[:id])
    render :layout => "form_page"
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @commentable.comments.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.commentable_type == 'Todo' ? [@commentable.project, @commentable] : @commentable, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = @commentable.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment.commentable_type == 'Todo' ? [@commentable.project, @commentable] : @commentable, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @commentable }
      format.json { head :no_content }
    end
  end

private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    if resource == 'modules'
      resource = 'clusters'
    elsif resource == 'bibliography'
      resource = 'references'
    end
    @commentable = resource.singularize.classify.constantize.find(id)
  end

end
