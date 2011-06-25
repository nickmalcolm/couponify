require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
class CustomerMatchingTest < ActiveSupport::TestCase
  
  def setup
    @customer = Factory(:customer, :orders_count => 1)
  end
  
  test "customer matches empty template" do
    #0% discount for all customers
    assert @customer.matches?(Factory(:discount_template, :value => 0, 
    :customer_criteria => "all", :discount_type => "percentage"))
  end
  
  test "customer matches new when order count is 1" do
    assert @customer.matches?(Factory(:discount_template, :value => 0, 
    :customer_criteria => "new", :discount_type => "percentage"))
  end
  
  test "customer doesn't match new when order count is > 1" do
    @customer.update_attributes(:orders_count => 2)
    assert !@customer.matches?(Factory(:discount_template, :value => 0, 
    :customer_criteria => "new", :discount_type => "percentage"))
  end
  
  test "customer matches all when order count is anything" do
    all = Factory(:discount_template, :value => 0, 
    :customer_criteria => "all", :discount_type => "percentage")
    
    10.times do
      @customer.update_attributes(:orders_count => rand(1000))
      assert @customer.matches?(all)
    end
  end
  
  test "customer doesn't match repeat when count is 1" do
    assert !@customer.matches?(Factory(:discount_template, :value => 0, 
    :customer_criteria => "repeat", :discount_type => "percentage"))
  end
  
  test "customer does match repeat when order count is > 1" do
    @customer.update_attributes(:orders_count => 2)
    assert @customer.matches?(Factory(:discount_template, :value => 0, 
    :customer_criteria => "repeat", :discount_type => "percentage"))
  end
  
  
  
      
  
end