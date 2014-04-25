class ProjectsSessionController < ApplicationController
  def create
    if user_signed_in?
      project = Project.find(params[:project_id])
      if project && project.members.exists?(current_user)
        session[:project_id] = project.id
        redirect_to [project, 'dashboard'], :notice => "Changed aspect to #{current_aspect.name}."
      else
        flash.now[:alert] = "Something went wrong."
        redirect_to :back, :alert => "Error. Perhaps you are not allowed to use this aspect?"
      end
    end
  end

  def destroy
    session[:project_id] = nil
    redirect_to dashboard_url, :notice => "Exited project aspect."
  end
end
