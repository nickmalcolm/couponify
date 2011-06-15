require 'test_helper'

class DiscountTemplateTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  test "need value type and minimum amount" do
    d = DiscountTemplate.new(
      :value => 0.00, 
      :type=>"percentage", 
      :minimum_order_amount => 0.00)
      
    assert d.valid?
    assert d.save!
    assert_equal 0.00, d.value
    assert_equal "percentage", d.type
    assert_equal 0.00, d.minimum_order_amount
  end
  
  test "10% for order of > $10.50 one use" do
    d = DiscountTemplate.new(
      :value => 10, 
      :type=>"percentage", 
      :minimum_order_amount => 10.50,
      :usage_limit => 1
      )
      
    assert d.valid?
    assert d.save!
    assert_equal 10.00, d.value
    assert_equal "percentage", d.type
    assert_equal 10.50, d.minimum_order_amount
    assert_equal 1, d.usage_limit
  end
  
  test "$5.50 for any order 10 uses" do
    d = DiscountTemplate.new(
      :value => 5.50, 
      :type=>"fixed_amount", 
      :usage_limit => 10
      )
      
    #assert d.valid?
    assert d.save!
    assert_equal 5.50, d.value
    assert_equal "fixed_amount", d.type
    assert_nil d.minimum_order_amount
    assert_equal 10, d.usage_limit
  end
  
  test "can't have negative percentage" do
    d = Factory(:discount_template, :type=>"percentage")
    d.value = -1
    assert d.invalid?
  end
  
  test "can't have negative fixed value" do
    d = Factory(:discount_template, :type=>"fixed_amount")
    d.value = -1
    assert d.invalid?
  end
  
  test "can't have negative minimum order amount" do
    d = Factory(:discount_template)
    d.minimum_order_amount = -1
    assert d.invalid?
  end
  
  test "can't have percentage over 100" do
    d = Factory(:discount_template, :type=>"percentage")
    d.value = 101
    assert d.invalid?
  end
  
end
