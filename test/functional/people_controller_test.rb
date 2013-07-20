require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post :create, person: { account_id: @person.account_id, created_by: @person.created_by, date_of_birth: @person.date_of_birth, date_of_death: @person.date_of_death, end_of_activity: @person.end_of_activity, first_name: @person.first_name, gender: @person.gender, grade: @person.grade, last_name: @person.last_name, nickname: @person.nickname, profession: @person.profession, public_email: @person.public_email, start_of_activity: @person.start_of_activity, updated_by: @person.updated_by }
    end

    assert_redirected_to person_path(assigns(:person))
  end

  test "should show person" do
    get :show, id: @person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person
    assert_response :success
  end

  test "should update person" do
    put :update, id: @person, person: { account_id: @person.account_id, created_by: @person.created_by, date_of_birth: @person.date_of_birth, date_of_death: @person.date_of_death, end_of_activity: @person.end_of_activity, first_name: @person.first_name, gender: @person.gender, grade: @person.grade, last_name: @person.last_name, nickname: @person.nickname, profession: @person.profession, public_email: @person.public_email, start_of_activity: @person.start_of_activity, updated_by: @person.updated_by }
    assert_redirected_to person_path(assigns(:person))
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete :destroy, id: @person
    end

    assert_redirected_to people_path
  end
end
