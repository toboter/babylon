require 'test_helper'

class ProjectReferencesControllerTest < ActionController::TestCase
  setup do
    @project_reference = project_references(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_references)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_reference" do
    assert_difference('ProjectReference.count') do
      post :create, project_reference: { project_id: @project_reference.project_id, reference_id: @project_reference.reference_id }
    end

    assert_redirected_to project_reference_path(assigns(:project_reference))
  end

  test "should show project_reference" do
    get :show, id: @project_reference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_reference
    assert_response :success
  end

  test "should update project_reference" do
    put :update, id: @project_reference, project_reference: { project_id: @project_reference.project_id, reference_id: @project_reference.reference_id }
    assert_redirected_to project_reference_path(assigns(:project_reference))
  end

  test "should destroy project_reference" do
    assert_difference('ProjectReference.count', -1) do
      delete :destroy, id: @project_reference
    end

    assert_redirected_to project_references_path
  end
end
