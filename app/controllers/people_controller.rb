class PeopleController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  # GET /people
  # GET /people.json
  def index
    @people = Person.order(:last_name)

    respond_to do |format|
      format.html { render :layout => "index_page" } # index.html.erb
      format.json { render json: @people }
    end
    
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])
    if request.path != person_path(@person)
      redirect_to @person, status: :moved_permanently
    else
      @attachable = @person
      @buckets = @attachable.buckets
      @profile_picture = Asset.find(@buckets.with_profile_pictures.first.cover_asset_id) if @buckets.with_profile_pictures.first.cover_asset_id
      @bucket = Bucket.new
  
      respond_to do |format|
        format.html { render :layout => "show_page" } # show.html.erb
        format.json { render json: @person }
      end
    end
    
  end

  # GET /people/new
  # GET /people/new.json
  def new
    if params[:user_id]
      @person = Person.new(:user_id => params[:user_id])
    else
      @person = Person.new(:user_id => nil)
    end

    respond_to do |format|
      format.html { render :layout => "form_page" }# new.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])

    render :layout => "form_page"
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end



  def connect_to_user
    @person = Person.find(params[:person_id])
    if params[:connect_user_id]
      @user = User.find(params[:connect_user_id])

      if @person.update_attribute(:user_id, @user.id)
        redirect_to @person, notice: "#{@person.fullname} is now connected to #{@user.username}."
      else
        redirect_to root_url, notice: "Error on update."
      end
    else
      redirect_to root_url, notice: "Error, wrong or missing data. #{params}"
    end
  end

  def disconnect_user
    @person = Person.find_by_user_id(params[:user_id])
    @user = User.find_by_id(params[:user_id])
    if @person.update_attribute(:user_id, nil)
      redirect_to @person, notice: "#{@person.fullname} is no longer connected to #{@user.username}."
    else
      redirect_to root_url, notice: "Error on update."
    end
  end

end