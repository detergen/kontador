require 'test_helper'

class BankaccsControllerTest < ActionController::TestCase
  setup do
    @bankacc = bankaccs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bankaccs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bankacc" do
    assert_difference('Bankacc.count') do
      post :create, bankacc: @bankacc.attributes
    end

    assert_redirected_to bankacc_path(assigns(:bankacc))
  end

  test "should show bankacc" do
    get :show, id: @bankacc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bankacc
    assert_response :success
  end

  test "should update bankacc" do
    put :update, id: @bankacc, bankacc: @bankacc.attributes
    assert_redirected_to bankacc_path(assigns(:bankacc))
  end

  test "should destroy bankacc" do
    assert_difference('Bankacc.count', -1) do
      delete :destroy, id: @bankacc
    end

    assert_redirected_to bankaccs_path
  end
end
