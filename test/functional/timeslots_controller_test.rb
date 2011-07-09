require 'test_helper'

class TimeslotsControllerTest < ActionController::TestCase
  setup do
    @timeslot = timeslots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:timeslots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create timeslot" do
    assert_difference('Timeslot.count') do
      post :create, :timeslot => @timeslot.attributes
    end

    assert_redirected_to timeslot_path(assigns(:timeslot))
  end

  test "should show timeslot" do
    get :show, :id => @timeslot.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @timeslot.to_param
    assert_response :success
  end

  test "should update timeslot" do
    put :update, :id => @timeslot.to_param, :timeslot => @timeslot.attributes
    assert_redirected_to timeslot_path(assigns(:timeslot))
  end

  test "should destroy timeslot" do
    assert_difference('Timeslot.count', -1) do
      delete :destroy, :id => @timeslot.to_param
    end

    assert_redirected_to timeslots_path
  end
end
