class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def personal
    # session[:project_id] = nil
  	@todos = current_user.todos
  	@todos_by_date = @todos.group_by(&:due_to)
  	@date = params[:date] ? Date.parse(params[:date]) : Date.today
  	render :layout => "index_page"
  end

  def project
  	@todos = current_aspect.todos
  	@todos_by_date = @todos.group_by(&:due_to)
  	@date = params[:date] ? Date.parse(params[:date]) : Date.today
  	render :layout => "index_page"
  end
end
