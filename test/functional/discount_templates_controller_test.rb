require 'test_helper'

class DiscountTemplatesControllerTest < ActionController::TestCase
  setup do
    @discount_template = Factory(:discount_template)
  end

  test "should not get index" do
    get :index
    assert_redirected_to login_path
    assert_not_nil flash[:error]
  end

  test "should not get new" do
    get :new
    assert_redirected_to login_path
    assert_not_nil flash[:error]
  end
  
  test "should not get create" do
    assert_difference('DiscountTemplate.count', 0) do
      post :create, :discount_template => @discount_template.attributes
    end
    assert_redirected_to login_path
    assert_not_nil flash[:error]
  end
  
  test "should show discount_template" do
    get :show, :id => @discount_template.to_param
    assert_redirected_to login_path
    assert_not_nil flash[:error]
  end

  test "should not get edit" do
    get :edit, :id => @discount_template.to_param
    assert_redirected_to login_path
    assert_not_nil flash[:error]
  end

  test "should not update discount_template" do
    put :update, :id => @discount_template.to_param, :discount_template => @discount_template.attributes
    assert_redirected_to login_path
    assert_not_nil flash[:error]
  end

  test "should not destroy discount_template" do
    assert_difference('DiscountTemplate.count', 0) do
      delete :destroy, :id => @discount_template.to_param
    end
    
    assert_redirected_to login_path
    assert_not_nil flash[:error]
  end
  
end
class LoggedInDiscountTemplatesControllerTest < ActionController::TestCase
  tests DiscountTemplatesController
  
  setup do
    @shop = Factory(:shop)
    login_as(@shop)
    @discount_template = Factory(:discount_template, :shop => @shop, 
      :order_placed_after => DateTime.now.beginning_of_day, 
      :order_placed_before => 2.days.from_now.beginning_of_day,
      :title => "Cool Promotion")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert assigns(:discount_templates).include? @discount_template
  end
  
  test "index shouldn't show other templates" do
    d = Factory(:discount_template, :shop => Factory(:shop), 
      :order_placed_after => DateTime.now.beginning_of_day, 
      :order_placed_before => 2.days.from_now.beginning_of_day,
      :title => "Cooler Promotion")
    
    get :index
    assert !(assigns(:discount_templates).include? d)
  end
  
  test "index json should contain events" do
    get :index, :start => 100.days.ago.to_i, :end => 100.days.from_now.to_i, :format => 'json'
    
    json = (JSON.parse response.body)[0]
    
    assert_equal @discount_template.id, json["id"].to_i
    assert_equal @discount_template.order_placed_after.to_i, DateTime.parse(json["start"]).to_i
    assert_equal @discount_template.order_placed_before.to_i, DateTime.parse(json["end"]).to_i
    assert_equal true, json["all_day"]
    assert_equal "discount_templates/#{@discount_template.id}/", json["url"]
    assert_equal "Cool Promotion", json["title"]
  end
  
  
  test "index json shouldn't show other shop's templates" do
    d = Factory(:discount_template, :shop => Factory(:shop), 
      :order_placed_after => DateTime.now.beginning_of_day, 
      :order_placed_before => 2.days.from_now.beginning_of_day,
      :title => "Cooler Promotion")
    
    get :index, :start => 100.days.ago.to_i, :end => 100.days.from_now.to_i, :format => 'json'
    json_arr = (JSON.parse response.body)
    
    assert_equal 1, json_arr.size
  end
  
  test "index shouldn't show other shop's discounts" do
    d = Factory(:discount)
    get :index
    assert !(assigns(:discount_templates).include? d)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create discount_template" do
    assert_difference('DiscountTemplate.count') do
      post :create, :discount_template => @discount_template.attributes
    end
    
    assert DiscountTemplate.last.shop = @shop
    assert_redirected_to discount_templates_path
    assert_not_nil flash[:notice]
  end

  test "should show discount_template" do
    get :show, :id => @discount_template.to_param
    assert_response :success
  end
  
  test "shouldn't show other shop's templates" do
    assert_raises ActiveRecord::RecordNotFound do
      get :show, :id => Factory(:discount_template).to_param
    end
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

class VariousDiscountTemplatesControllerTest < ActionController::TestCase
  tests DiscountTemplatesController
  
  setup do
   @discount_template = Factory(:discount_template)
   @now = DateTime.now.utc.midnight
   @sft = "%d %b %Y"
   @defaults = {:usage_limit =>"1", 
                :customer_criteria =>"repeat", 
                :order_placed_after => @now.strftime(@sft), 
                :order_placed_before =>"",
                :discount_type =>"fixed_amount", 
                :minimum_order_amount =>"", 
                :value =>""}
    login_as(Factory(:shop))
  end
  
  test "creating should fail with no params" do
    assert_difference "DiscountTemplate.count", 0 do
      post :create
    end
  end
  
  test "creating with defaults should fail" do
    assert_difference "DiscountTemplate.count", 0 do
      post :create, :discount_template => @defaults
    end
  end
  
  test "defaults with $2USD should succeed" do
    params = @defaults
    params[:value] = 2
    
    assert_difference "DiscountTemplate.count", 1 do
      post :create, :discount_template => params
    end
    
    dt = DiscountTemplate.last
    
    #Order Criteria
    assert_equal "repeat", dt.customer_criteria
    assert_equal 0.00, dt.minimum_order_amount.to_f
    assert_equal @now, dt.order_placed_after
    assert_nil dt.order_placed_before
    
    #Discount criteria
    assert_equal 2.00, dt.value.to_f
    assert_equal "fixed_amount", dt.discount_type
    assert_equal 1, dt.usage_limit
  end
  
  test "5 time 25% off for all new customers with orders over $5.76, used between now and next week" do
    params = @defaults
    params[:value] = 25
    params[:discount_type] = "percentage"
    params[:customer_criteria] = "new"
    params[:usage_limit] = 5
    params[:minimum_order_amount] = 5.76
    
    assert_difference "DiscountTemplate.count", 1 do
      post :create, :discount_template => params
    end
    
    dt = DiscountTemplate.last
    
    #Order Criteria
    assert_equal "new", dt.customer_criteria
    assert_equal 5.76, dt.minimum_order_amount.to_f
    assert_equal @now, dt.order_placed_after
    assert_nil dt.order_placed_before
    
    #Discount criteria
    assert_equal 25.00, dt.value.to_f
    assert_equal "percentage", dt.discount_type
    assert_equal 5, dt.usage_limit
  end
  
  test "can't have coupon last less than one day" do
    params = @defaults
    params[:ends_at] = @now
    
    assert_difference "DiscountTemplate.count", 0 do
      post :create, :discount_template => params
    end
  end
  
  test "can't have orders placed before after" do
    params = @defaults
    params[:order_placed_after] = @now+2.days
    params[:order_placed_before] = @now
    
    assert_difference "DiscountTemplate.count", 0 do
      post :create, :discount_template => params
    end
  end
  
end