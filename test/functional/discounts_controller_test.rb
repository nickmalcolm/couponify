require 'test_helper'

class DiscountsControllerTest < ActionController::TestCase
  setup do
    @discount = Factory(:discount)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discounts)
  end

  test "shouldn't get new" do
    assert_raises ActionController::RoutingError do
      get :new
    end
  end

  test "shouldn't create discount" do
    assert_raises ActionController::RoutingError do
      post :create, :discount => {:customer => Factory(:fake_customer)}
    end
  end

  test "should show discount" do
    get :show, :id => @discount.to_param
    assert_response :success
  end

  test "shouldn't get edit" do
    assert_raises ActionController::RoutingError do
      get :edit, :id => @discount.to_param
    end
  end

  test "shouldn't update discount" do
    assert_raises ActionController::RoutingError do
      put :update, :id => @discount.to_param, :discount => @discount.attributes
    end
  end

  test "shouldn't destroy discount" do
    assert_raises ActionController::RoutingError do
      delete :destroy, :id => @discount.to_param
    end
  end
end
