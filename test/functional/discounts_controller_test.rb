require 'test_helper'

class DiscountsControllerTest < ActionController::TestCase
  setup do
    @discount = Factory(:discount)
  end

  test "shouldn't get index when logged out" do
    get :index
    assert_redirected_to login_path
    assert_not_nil flash[:error]
  end
  
  test "shouldn't show discount when logged out" do
    get :show, :id => @discount.to_param
    assert_redirected_to login_path
    assert_not_nil flash[:error]
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
require 'test_helper'

class LoggedInDiscountsControllerTest < ActionController::TestCase
  tests DiscountsController
  
  setup do
    shop = Factory(:shop)
    @discount = Factory(:discount, :shop => shop)
    @boo = Factory(:discount)
    login_as shop
  end

  test "should get index" do
    get :index
    assert_response :success
    discounts = assigns(:discounts)
    assert_not_nil discounts
    assert discounts.include? @discount
  end
  
  test "index shouldn't show other shop's discount" do
    get :index
    assert !(assigns(:discounts).include? @boo)
  end

  test "should show discount" do
    get :show, :id => @discount.to_param
    assert_response :success
    assert_equal @discount, assigns(:discount)
  end
  
  test "show shouldn't show other shop's discount" do
    assert_raises ActiveRecord::RecordNotFound do
      get :show, :id => @boo.to_param
    end
  end
  
end

