class ActivitiesController < ApplicationController

  def index
  	if params[:person_id]
  	  @person = Person.find(params[:person_id])
  	  @activities = @person.user.activities.order("created_at desc")
  	else
      @activities = Activity.order("created_at desc")
    end

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.json { render json: @activities }
    end
  end
  
end
