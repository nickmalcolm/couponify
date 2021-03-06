require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def setup
    @shop = Factory(:shop)
  end
  
  test "can create order with necessary values" do
    assert Order.new(:email => "bob@example.com",
                  :total_price => 7.00, :total_discounts => 0,
                  :shopify_id => 1234, :total_line_items_price => 7.00,
                  :subtotal_price => 7.00, :buyer_accepts_marketing => true,
                  :shop => @shop).valid?
  end
  
  test "can create order with necessary + discount values" do
    assert Order.new(:email => "bob@example.com", 
                  :total_price => 4.5, :total_discounts => 2.50,
                  :shopify_id => 1234, :total_line_items_price => 7.00,
                  :subtotal_price => 7.00, :buyer_accepts_marketing => true,
                  :discount_code => "123ABC", :shop => @shop).valid?
  end
  
  test "can't have blank order" do
    assert Order.new().invalid?
  end
  
end
class OrderMatchingTest < ActiveSupport::TestCase
  
  def setup
    @order = Factory(:order)
    @order.created_at = 1.day.from_now
    @order.save!
    @order.customer = Factory(:customer, :orders_count => 1)
  end
  
  test "order doesn't match template without dates" do
    #0% discount for all customers
    assert !@order.matches?(Factory(:discount_template, :value => 0, 
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
  
  test "any order matches minimum amount of 0" do
    assert @order.matches?(Factory(:discount_template, :value => 0, 
    :customer_criteria => "all", :discount_type => "percentage",
    :order_placed_after => DateTime.now, :order_placed_before => 2.days.from_now,
    :minimum_order_amount => 0))
  end
  
  test "order doesn't match minimum amount of $7.01" do
    assert !@order.matches?(Factory(:discount_template, :value => 0, 
    :customer_criteria => "all", :discount_type => "percentage",
    :order_placed_after => DateTime.now, :order_placed_before => 2.days.from_now,
    :minimum_order_amount => 7.01))
  end
  
  test "order matches with all customer criteria" do
    assert @order.matches?(Factory(:discount_template, :value => 0, 
    :order_placed_after => DateTime.now, :order_placed_before => 2.days.from_now,
    :customer_criteria => "all", :discount_type => "percentage"))
  end
  
  test "order matches with new customer criteria" do
    assert @order.matches?(Factory(:discount_template, :value => 0, 
    :order_placed_after => DateTime.now, :order_placed_before => 2.days.from_now,
    :customer_criteria => "new", :discount_type => "percentage"))
  end
  
  test "order doesn't match with repeat customer criteria" do
    assert !@order.matches?(Factory(:discount_template, :value => 0, 
    :order_placed_after => DateTime.now, :order_placed_before => 2.days.from_now,
    :customer_criteria => "repeat", :discount_type => "percentage"))
  end

  test "order doesn't match with repeat customer criteria when we increase order count" do
    @order.customer.update_attributes(:orders_count => 2)
    
    assert @order.matches?(Factory(:discount_template, :value => 0, 
    :order_placed_after => DateTime.now, :order_placed_before => 2.days.from_now,
    :customer_criteria => "repeat", :discount_type => "percentage"))
  end

end