require 'test_helper'

class ProductOrgsControllerTest < ActionController::TestCase
  setup do
    @product_org = product_orgs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_orgs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_org" do
    assert_difference('ProductOrg.count') do
      post :create, product_org: @product_org.attributes
    end

    assert_redirected_to product_org_path(assigns(:product_org))
  end

  test "should show product_org" do
    get :show, id: @product_org
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_org
    assert_response :success
  end

  test "should update product_org" do
    put :update, id: @product_org, product_org: @product_org.attributes
    assert_redirected_to product_org_path(assigns(:product_org))
  end

  test "should destroy product_org" do
    assert_difference('ProductOrg.count', -1) do
      delete :destroy, id: @product_org
    end

    assert_redirected_to product_orgs_path
  end
end
