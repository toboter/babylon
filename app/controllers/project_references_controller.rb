class ProjectReferencesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # POST /project_references
  # POST /project_references.json
  def create
    @project_reference = ProjectReference.new
    @project_reference.project_id = current_aspect.id
    @project_reference.reference_id = params[:reference_id]

    respond_to do |format|
      if @project_reference.save
        track_activity @project_reference
        format.html { redirect_to :back, notice: 'Project reference was successfully created.' }
        format.json { render json: @project_reference, status: :created, location: @project_reference }
      else
        format.html { redirect_to :back, alert: 'An error occured.' }
        format.json { render json: @project_reference.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /project_references/1
  # DELETE /project_references/1.json
  def destroy
    @project_reference = current_aspect.project_references.find_by_reference_id(params[:reference_id])
    @project_reference.destroy
    track_activity @project_reference

    respond_to do |format|
      format.html { redirect_to :back, notice: "Removed reference from #{current_aspect.name}." }
      format.json { head :no_content }
    end
  end
end
