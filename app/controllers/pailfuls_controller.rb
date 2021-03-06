class PailfulsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_pailful, :only => :destroy
  load_and_authorize_resource

  def create
  	@bucket = Bucket.find(params[:id])
  	@assets = Asset.find(params[:asset_ids])
  	@bucket.assets << @assets

  	if @bucket.save
  	  redirect_to [@bucket.attachable, @bucket], notice: "added #{@assets.count}, all #{@bucket.assets.count}"
  	else
  	  redirect_to [@bucket.attachable, @bucket], notice: "Error. No assets added."
  	end
  end

  def destroy
  	@pailful.destroy
  	redirect_to [@bucket.attachable, @bucket], notice: "Deleted asset from bucket."
  end


  private

  def find_pailful
    @bucket = Bucket.find(params[:id])
    @pailful = @bucket.pailfuls.where(asset_id: params[:asset_id]).first
  end

end
