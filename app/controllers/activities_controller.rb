class ActivitiesController < ApplicationController

  def index
  	if params[:person_id]
  	  @person = Person.find(params[:person_id])
  	  @activities = @person.user.activities.order("created_at desc").paginate(page: params[:page], per_page: params[:per_page] ? params[:per_page] : 30)
  	else
      @activities = Activity.order("created_at desc").paginate(page: params[:page], per_page: params[:per_page] ? params[:per_page] : 30)
    end

    respond_to do |format|
      format.html { render :layout => "fluid" }# index.html.erb
      format.json { render json: @activities }
    end
  end
  
end
