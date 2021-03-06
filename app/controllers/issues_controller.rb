class IssuesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :load_issuable
  load_and_authorize_resource

  # GET /issues
  # GET /issues.json
  def index
    if @issuable
      if @issuable.class.to_s == 'Project'
        @pre_issues = @issuable.issues
        @pre_issues.concat(@issuable.lists.map{|l| l.studies.map{|s| s.issues }}.flatten)
      else
        @pre_issues = @issuable.issues.order('sequential_id DESC')
      end
    else
      @pre_issues = Issue.scoped
    end

    @issues = @pre_issues
    
    unless params[:state]
      params[:state] = 'open'
    end

    if params[:state] == 'open'
      @issues = @issues.where(closed: false)
    end
    if params[:state] == 'closed'
      @issues = @issues.where(closed: true)
    end
    if params[:creator]
      @issues = @issues.where(creator_id: params[:creator])
    end
    if params[:assignee]
      @issues = @issues.where(assigned_id: params[:assignee])
    end
    if params[:aspect]
      @project = Project.find(params[:aspect])
      @issues = @project.issues
    end

    respond_to do |format|
      format.html { render layout: 'fluid' }# index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @issue = @issuable.issues.find(params[:id])

    respond_to do |format|
      format.html { render layout: 'fluid' }# show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new
    @issue = @issuable.issues.new
    @issue.comments.build

    respond_to do |format|
      format.html { render layout: 'form' }# new.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    @issue = @issuable.issues.find(params[:id])
    render layout: 'form'
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = @issuable.issues.new(params[:issue])

    respond_to do |format|
      if @issue.save
        track_activity(@issuable, 'open', nil, @issue)
        format.html { redirect_to [@issuable, @issue], notice: 'Issue was successfully created.' }
        format.json { render json: @issue, status: :created, location: @issue }
      else
        format.html { render layout: 'form', action: "new" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /issues/1
  # PUT /issues/1.json
  def update
    @issue = @issuable.issues.find(params[:id])
    @changed = @issue.closed != params[:closed]

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        (@changed == true && @issue.closed == true) ? (track_activity(@issuable, 'close', nil, @issue)) : (track_activity(@issuable, 'update', @issue.previous_changes, @issue))

        format.html { redirect_to [@issuable, @issue], notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render layout: 'form', action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def close
    @issue = Issue.find(params[:id])

    respond_to do |format|
      if @issue.update_attribute(:closed, true)
        track_activity(@issue.issuable, 'close', nil, @issue)

        format.html { redirect_to [@issue.issuable, @issue], notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end   

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue = @issuable.issues.find(params[:id])
    @issue.destroy
    track_activity @issue

    respond_to do |format|
      format.html { redirect_to [@issuable, :issues] }
      format.json { head :no_content }
    end
  end

  def new_comment
    @issue = Issue.find(params[:id])
    @comment = @issue.comments.new
    @comment.content = params[:content]

    respond_to do |format|
      if @comment.save
        if @issue.closed == true
          @issue.update_attribute(:closed, false)
        end
        track_activity(@issue.issuable, 'add', nil, @comment)
        format.html { redirect_to [@issue.issuable, @issue], notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to [@issue.issuable, @issue], alert: 'Comment was not created. Perhaps content was blank?' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

private

  def load_issuable
    resource, id = request.path.split('/')[1, 2]
    if resource == 'modules'
      resource = 'clusters'
    end
    if id == nil || resource == 'issues'
      @issuable = nil
    else
      @issuable = resource.singularize.classify.constantize.find(id)
    end
  end
end
