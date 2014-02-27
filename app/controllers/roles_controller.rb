class RolesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def update_multiple
    @roles = Role.update(params[:roles].keys, params[:roles].values)
    @roles.reject! { |p| p.errors.empty? }
    if @roles.empty?
      redirect_to dashboard_url, :notice => "Successfully updated roles."
    else
      redirect_to dashboard_url, :notice => "Error while updating records."
    end
  end


end
