class ActionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource :item
  load_and_authorize_resource :through => :item
  
  # GET /actions
  # GET /actions.json
  def index

    respond_to do |format|
      format.html { render layout: 'fluid' }# index.html.erb
      format.json { render json: @actions }
    end
  end

  # GET /actions/1
  # GET /actions/1.json
  def show

    respond_to do |format|
      format.html { render layout: 'fluid' }# show.html.erb
      format.json { render json: @action }
    end
  end

end
