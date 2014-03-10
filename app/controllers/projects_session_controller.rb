class ProjectsSessionController < ApplicationController
  def create
    if user_signed_in?
      project = Project.find(params[:project_id])
      if project
        session[:project_id] = project.id
        redirect_to :back, :notice => "Changed aspect to #{current_aspect.name}."
      else
        flash.now[:alert] = "Something went wrong."
        redirect_to :back, :notice => "Error."
      end
    end
  end

  def destroy
    session[:project_id] = nil
    redirect_to dashboard_url, :notice => "Exited project aspect."
  end
end
