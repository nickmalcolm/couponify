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
    @order.created_at = 1.day.from_now
    @order.save!
    @customer = Factory(:customer, :shopify_id => @order.shopify_customer_id, :orders_count => 1)
  end
  
  test "order matches empty template" do
    #0% discount for all customers
    assert @order.matches?(Factory(:discount_template, :value => 0, 
    :customer_criteria => "all", :discount_type => "percentage"))
  end
  
  test "order matches template with date range" do
    assert @order.matches?(Factory(:discount_template, :value => 0, 
    :customer_criteria => "all", :discount_type => "percentage", 
    :order_placed_after => DateTime.now, :order_placed_before => 2.days.from_now))
  end
  
  test "order doesn't match template outside date range" do
    assert !@order.matches?(Factory(:discount_template, :value => 0, 
    :customer_criteria => "all", :discount_type => "percentage", 
    :order_placed_after => 2.days.from_now, :order_placed_before => 4.days.from_now))
    
    assert !@order.matches?(Factory(:discount_template, :value => 0, 
    :customer_criteria => "all", :discount_type => "percentage", 
    :order_placed_after => DateTime.now, :order_placed_before => 2.hours.from_now))
  end

end