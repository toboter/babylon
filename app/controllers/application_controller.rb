class ApplicationController < ActionController::Base
  protect_from_forgery
  include Userstamp
  helper :layout
  before_filter :load_static

  def after_sign_in_path_for(resource)
    dashboard_path
  end

private
  def load_static
  	@clusters = Cluster.all
  end

end
