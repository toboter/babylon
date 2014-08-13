class ActivitiesController < ApplicationController
  before_filter :set_trackable

  def index
  	if @trackable && @trackable.class.to_s == 'Person'
  	  @person = Person.find(params[:person_id])
  	  @activities = @person.user.activities.order("created_at desc").paginate(page: params[:page], per_page: params[:per_page] ? params[:per_page] : 30)
    elsif @trackable && @trackable.class.to_s != 'Person'
      @activities = @trackable.activities.order("created_at desc").paginate(page: params[:page], per_page: params[:per_page] ? params[:per_page] : 30)
  	else
      @activities = Activity.order("created_at desc").paginate(page: params[:page], per_page: params[:per_page] ? params[:per_page] : 30)
    end

    respond_to do |format|
      format.html { render layout: 'fluid' }# index.html.erb
      format.json { render json: @activities }
    end
  end
  
private

  def set_trackable
    resource, id = request.path.split('/')[1, 2]
    if id
      @trackable = resource.singularize.classify.constantize.find(id)
    end
  end
end
