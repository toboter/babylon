class ApplicationController < ActionController::Base
  protect_from_forgery
  include ControllerAspect
  include Userstamp
  helper :layout

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  rescue_from CanCan::AccessDenied do |exception|
 	  redirect_to root_url, :alert => exception.message
  end

private
  def track_activity(trackable, action = params[:action], changes_content=nil, targetable=nil)
  	current_user.activities.create! action: action, trackable: trackable, changes_content: changes_content, targetable: targetable
  end

end
