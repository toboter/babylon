class StudyassignmentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource


  # POST /studyassignments
  # POST /studyassignments.json
  def create
    @studyassignment = Studyassignment.new
    @studyassignment.project_id = params[:project_id]
    @studyassignment.item_id = params[:item_id]

    respond_to do |format|
      if @studyassignment.save
        format.html { redirect_to :back, notice: 'Item successfully added to workspace.' }
        format.json { render json: @studyassignment, status: :created, location: @studyassignment }
      else
        format.html { redirect_to :back, alert: 'An error occured.' }
        format.json { render json: @studyassignment.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /studyassignments/1
  # DELETE /studyassignments/1.json
  def destroy
    @project = Project.find(params[:project_id])
    @studyassignment = @project.studyassignments.find_by_item_id(params[:item_id])
    @studyassignment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end