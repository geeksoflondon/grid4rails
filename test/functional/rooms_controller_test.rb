require 'test_helper'

class RoomsControllerTest < ActionController::TestCase
  setup do
    @room = rooms(:chx)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rooms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create room" do
    @new_room = rooms(:chx)
    @new_room['short_code'] = 'CHX1'

    assert_difference('Room.count') do
      post :create, :room => @new_room.attributes
    end

    assert_redirected_to room_path(assigns(:room))
  end

  test "should show room" do
    get :show, :id => @room.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @room.to_param
    assert_response :success
  end

  test "should update room" do
    put :update, :id => @room.to_param, :room => @room.attributes
    assert_redirected_to room_path(assigns(:room))
  end

  test "should destroy room" do
    assert_difference('Room.count', -1) do
      delete :destroy, :id => @room.to_param
    end

    assert_redirected_to rooms_path
  end
end
