require 'test_helper'

class ItemClassificationsControllerTest < ActionController::TestCase
  setup do
    @item_classification = item_classifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_classifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_classification" do
    assert_difference('ItemClassification.count') do
      post :create, item_classification: { description: @item_classification.description, name: @item_classification.name, parent_id: @item_classification.parent_id }
    end

    assert_redirected_to item_classification_path(assigns(:item_classification))
  end

  test "should show item_classification" do
    get :show, id: @item_classification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_classification
    assert_response :success
  end

  test "should update item_classification" do
    put :update, id: @item_classification, item_classification: { description: @item_classification.description, name: @item_classification.name, parent_id: @item_classification.parent_id }
    assert_redirected_to item_classification_path(assigns(:item_classification))
  end

  test "should destroy item_classification" do
    assert_difference('ItemClassification.count', -1) do
      delete :destroy, id: @item_classification
    end

    assert_redirected_to item_classifications_path
  end
end
