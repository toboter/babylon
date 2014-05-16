class ActivitiesController < ApplicationController

  def index
    @activities = Activity.order("created_at desc")

    respond_to do |format|
      format.html { render :layout => "index_page" }# index.html.erb
      format.json { render json: @activities }
    end
  end
  
end
