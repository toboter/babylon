class ErrorsController < ApplicationController
  def show
    @exception = env["action_dispatch.exception"]
    respond_to do |format|
      format.html { render layout: 'escape', action: request.path[1..-1], status: request.path[1..-1] }
      format.json { render json: {status: request.path[1..-1], error: @exception.message}, status: request.path[1..-1] }
    end
  end
end
