require 'test_helper'

class DiscountTemplateTest < ActiveSupport::TestCase
  
  def setup
    @shop = Factory(:shop)
  end
  
  test "blank discount invalid" do
    assert DiscountTemplate.new.invalid?
  end
  
  test "need value, type, criteria, and shop" do
    
    d = DiscountTemplate.new(
      :value => 0.00, 
      :discount_type=>"percentage",
      :customer_criteria => "repeat",
      :shop => @shop)
      
    assert d.valid?
    assert d.save!
    assert_equal 0.00, d.value
    assert_equal "percentage", d.discount_type
    assert_equal "repeat", d.customer_criteria
    
    #auto for nils
    assert_equal DateTime.now.utc.beginning_of_day, d.order_placed_after
    assert_equal DateTime.now.utc.end_of_day, d.order_placed_before
  end
  
  test "10% for first order, when > $10.50, one use" do
    d = DiscountTemplate.new(
      :value => 10, 
      :discount_type=>"percentage", 
      :minimum_order_amount => 10.50,
      :usage_limit => 1,
      :customer_criteria => "new",
      :shop => @shop
      )
      
    assert d.valid?
    assert d.save!
    assert_equal 10.00, d.value
    assert_equal "percentage", d.discount_type
    assert_equal 10.50, d.minimum_order_amount
    assert_equal 1, d.usage_limit
    assert_equal "new", d.customer_criteria
  end
  
  test "$5.50 for any order 10 uses" do
    d = DiscountTemplate.new(
      :value => 5.50, 
      :discount_type=>"fixed_amount", 
      :usage_limit => 10,
      :customer_criteria => "new",
      :shop => @shop
      )
      
    assert d.valid?
    assert d.save!
    assert_equal 5.50, d.value
    assert_equal "fixed_amount", d.discount_type
    assert_equal "new", d.customer_criteria
    assert_equal 10, d.usage_limit
  end
  
  test "can't have negative percentage" do
    d = Factory(:discount_template, :discount_type=>"percentage")
    d.value = -1
    assert d.invalid?
  end
  
  test "can't have negative fixed value" do
    d = Factory(:discount_template, :discount_type=>"fixed_amount")
    d.value = -1
    assert d.invalid?
  end
  
  test "can't have negative minimum order amount" do
    d = Factory(:discount_template)
    d.minimum_order_amount = -1
    assert d.invalid?
  end
  
  test "can't have percentage over 100" do
    d = Factory(:discount_template, :discount_type=>"percentage")
    assert !d.update_attributes(:value => 101)
    assert d.invalid?
  end
  
  test "can't have orders_before before orders_after" do
    assert Factory.build(:discount_template, :order_placed_before => DateTime.now, :order_placed_after => 1.day.from_now).invalid?
  end
  
  test "start dates should be midnight" do
    date = DateTime.parse("12 July 2011 16:47")
    midnight = date.beginning_of_day
    d = Factory(:discount_template, :order_placed_after => date)
    assert_equal midnight, d.order_placed_after
  end
  
  test "only start date should automagically make end date same day" do
    date = DateTime.parse("12 July 2011 16:47")
    d = Factory(:discount_template, :order_placed_after => date.beginning_of_day)
    assert_equal date.end_of_day, d.order_placed_before
  end
  
  test "valid for 2 weeks after discount is generated" do
    d = Factory(:discount_template)
    d.days_valid = 14
    d.valid_type = "after_generated"
    assert d.valid?
  end
  
  test "valid for 30 days after template ends" do
    d = Factory(:discount_template)
    d.days_valid = 30
    d.valid_type = "after_end_date"
    assert d.valid?
  end
  
  test "valid types" do
    d = Factory(:discount_template)
    d.valid_type = "after_end_date"
    assert d.valid?
    
    d.valid_type = "after_generated"
    assert d.valid?
  
    d.valid_type = "random"
    assert d.invalid?
  end
  
end
class DiscountGenerationTest< ActiveSupport::TestCase

  def setup
   @shop = Factory(:shop)
   @order = Factory(:order, :customer => Factory(:customer, :orders_count => 1, :total_spent => 5.00), :total_price => 5.00)
  end
  
  test "can generate discount for order" do
    discount_template = Factory(:discount_template, :days_valid => 12, 
      :valid_type => "after_generated", :minimum_order_amount => 0.00, 
      :customer_criteria => "all", :shop => @shop)
      
    discount = discount_template.discount_for_order(@order)
    assert !discount.nil?
    assert_equal @order.customer, discount.customer
    assert_equal @shop, discount.shop
    
    assert_equal 12.days.from_now.utc.end_of_day, discount.expires_at
    
    assert discount_template.discounts.include? discount
  end
  
  test "can generate discount with expires after promotion finish" do
    discount_template = Factory(:discount_template, :days_valid => 12, 
      :valid_type => "after_end_date", :minimum_order_amount => 0.00, 
      :customer_criteria => "all", :shop => @shop, :order_placed_before => 5.days.from_now)
      
    discount = discount_template.discount_for_order(@order)
    
    assert_equal 17.days.from_now.utc.end_of_day, discount.expires_at
  end
  
end