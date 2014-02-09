class ApplicationController < ActionController::Base
  protect_from_forgery
  include Userstamp
  helper :layout

  def after_sign_in_path_for(resource)
    dashboard_path
  end

end
