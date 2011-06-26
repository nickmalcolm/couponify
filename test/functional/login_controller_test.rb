require 'test_helper'

class LoginControllerTest < ActionController::TestCase
 
  def setup
    @request_origin = "http://coming.from/here"
    session[:return_to] = @request_origin
  end
  
  test "when not logged in show index template" do
    get :index
    assert_response :success
  end
    
  test "redirect to authenticate action if shop is provided" do
    get :index, :shop => "german-brownies"
    assert_redirected_to :action => 'authenticate', :shop => "german-brownies"
  end
    
  test "redirect back if blank shop is provided" do
    get :authenticate, {:shop => ''}
    assert_redirected_to @request_origin
  end
    
  test "authenticate should redirect back if no shop is provided" do
    get :authenticate
    assert_redirected_to @request_origin
  end
      
  test "authenticate should redirect to shop's permission url if a shop is provided" do
    get :authenticate, {:shop => 'german-brownies'}
    assert_redirected_to ShopifyAPI::Session.new('german-brownies').create_permission_url
  end
    
  # test "finalize should redirect to stored return url in session" do
  #     login_as(Shop.new(:domain => "bob.com"))
  #     return_url = "/orders?id=123&shop=german-brownies"
  #     get :finalize, {:shop => 'german-brownies', :t => 'somerandomtoken'}, @request.session.merge(:return_to => return_url)
  #     assert_redirected_to return_url
  #   end
end