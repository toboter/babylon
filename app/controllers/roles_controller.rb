class RolesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @roles = Role.all
    authorize! :manage, 'roles'

    render :layout => "index_page"
  end

  def update_multiple
    authorize! :manage, 'roles'
    @roles = Role.update(params[:roles].keys, params[:roles].values)
    @roles.reject! { |p| p.errors.empty? }
    if @roles.empty?
      redirect_to roles_url, :notice => "Successfully updated roles."
    else
      redirect_to roles_url, :notice => "Error while updating records."
    end
  end


end
