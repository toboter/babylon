require 'test_helper'

class StudiesControllerTest < ActionController::TestCase
  setup do
    @study = studies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:studies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create study" do
    assert_difference('Study.count') do
      post :create, study: { properties: @study.properties, studyable_id: @study.studyable_id, studyable_type: @study.studyable_type }
    end

    assert_redirected_to study_path(assigns(:study))
  end

  test "should show study" do
    get :show, id: @study
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @study
    assert_response :success
  end

  test "should update study" do
    put :update, id: @study, study: { properties: @study.properties, studyable_id: @study.studyable_id, studyable_type: @study.studyable_type }
    assert_redirected_to study_path(assigns(:study))
  end

  test "should destroy study" do
    assert_difference('study.count', -1) do
      delete :destroy, id: @study
    end

    assert_redirected_to studies_path
  end
end
