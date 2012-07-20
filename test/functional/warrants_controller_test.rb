require 'test_helper'

class WarrantsControllerTest < ActionController::TestCase
  setup do
    @warrant = warrants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:warrants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create warrant" do
    assert_difference('Warrant.count') do
      post :create, warrant: @warrant.attributes
    end

    assert_redirected_to warrant_path(assigns(:warrant))
  end

  test "should show warrant" do
    get :show, id: @warrant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @warrant
    assert_response :success
  end

  test "should update warrant" do
    put :update, id: @warrant, warrant: @warrant.attributes
    assert_redirected_to warrant_path(assigns(:warrant))
  end

  test "should destroy warrant" do
    assert_difference('Warrant.count', -1) do
      delete :destroy, id: @warrant
    end

    assert_redirected_to warrants_path
  end
end
