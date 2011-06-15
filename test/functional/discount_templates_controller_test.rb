require 'test_helper'

class DiscountTemplatesControllerTest < ActionController::TestCase
  setup do
    @discount_template = discount_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discount_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create discount_template" do
    assert_difference('DiscountTemplate.count') do
      post :create, :discount_template => @discount_template.attributes
    end

    assert_redirected_to discount_template_path(assigns(:discount_template))
  end

  test "should show discount_template" do
    get :show, :id => @discount_template.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @discount_template.to_param
    assert_response :success
  end

  test "should update discount_template" do
    put :update, :id => @discount_template.to_param, :discount_template => @discount_template.attributes
    assert_redirected_to discount_template_path(assigns(:discount_template))
  end

  test "should destroy discount_template" do
    assert_difference('DiscountTemplate.count', -1) do
      delete :destroy, :id => @discount_template.to_param
    end

    assert_redirected_to discount_templates_path
  end
end
