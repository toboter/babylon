require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, item: { c_index: @item.c_index, c_name: @item.c_name, context_id: @item.context_id, e_date: @item.e_date, e_index: @item.e_index, e_name: @item.e_name, in_c_date: @item.in_c_date, item_type_id: @item.item_type_id, localisation_id: @item.localisation_id }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item
    assert_response :success
  end

  test "should update item" do
    put :update, id: @item, item: { c_index: @item.c_index, c_name: @item.c_name, context_id: @item.context_id, e_date: @item.e_date, e_index: @item.e_index, e_name: @item.e_name, in_c_date: @item.in_c_date, item_type_id: @item.item_type_id, localisation_id: @item.localisation_id }
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item
    end

    assert_redirected_to items_path
  end
end
