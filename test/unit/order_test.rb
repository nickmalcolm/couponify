require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  test "can create order with necessary values" do
    assert Order.new(:email => "bob@example.com",
                  :total_price => 7.00, :total_discounts => 0,
                  :shopify_id => 1234, :total_line_items_price => 7.00,
                  :subtotal_price => 7.00, :buyer_accepts_marketing => true,
                  :shopify_customer_id => 1234).valid?
  end
  
  test "can create order with necessary + discount values" do
    assert Order.new(:email => "bob@example.com", 
                  :total_price => 4.5, :total_discounts => 2.50,
                  :shopify_id => 1234, :total_line_items_price => 7.00,
                  :subtotal_price => 7.00, :buyer_accepts_marketing => true,
                  :shopify_customer_id => 1234, :discount_code => "123ABC").valid?
  end
  
  test "can't have blank order" do
    assert Order.new().invalid?
  end
  
  test "has a shopify_customer through Shopify ID" do
    c = Factory(:customer, :shopify_id => "1234456")
    o = Factory(:order, :shopify_customer_id => "1234456")
    
    assert_equal c, o.customer
  end
  
end
class OrderMatchingTest < ActiveSupport::TestCase
  
  def setup
    @order = Factory(:order)
    @customer = Factory(:customer, :shopify_id => @order.shopify_customer_id)
  end
  
  test "order doesn't match empty template" do
    assert !@order.matches?(Factory(:discount_template))
  end
end