class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
  	render :layout => "index_page"
  end
end
