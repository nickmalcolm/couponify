require 'test_helper'

class DiscountTemplateTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  test "need value type criteria and minimum amount" do
    
    d = DiscountTemplate.new(
      :value => 0.00, 
      :discount_type=>"percentage",
      :customer_criteria => "repeat")
      
    assert d.valid?
    assert d.save!
    assert_equal 0.00, d.value
    assert_equal "percentage", d.discount_type
    assert_equal "repeat", d.customer_criteria
  end
  
  test "10% for first order, when > $10.50, one use" do
    d = DiscountTemplate.new(
      :value => 10, 
      :discount_type=>"percentage", 
      :minimum_order_amount => 10.50,
      :usage_limit => 1,
      :customer_criteria => "new"
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
      :customer_criteria => "new"
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
  
  test "can't have dates before now" do
    assert Factory.build(:discount_template, :starts_at => 1.day.ago).invalid?
    assert Factory.build(:discount_template, :ends_at => 1.day.ago).invalid?
    assert Factory.build(:discount_template, :order_placed_after => 1.day.ago).invalid?
    assert Factory.build(:discount_template, :order_placed_before => 1.day.ago).invalid?
  end
  
  test "can't have coupon ends at equal or before starts" do
    odfn = 1.day.from_now
    assert Factory.build(:discount_template, :starts_at => odfn, :ends_at => odfn).invalid?
    assert Factory.build(:discount_template, :starts_at => odfn, :ends_at => DateTime.now).invalid?
  end
  
  test "can't have orders_before before or equal to orders_after" do
    odfn = 1.day.from_now
    assert Factory.build(:discount_template, :order_placed_before => odfn, :order_placed_after => odfn).invalid?
    assert Factory.build(:discount_template, :order_placed_before => DateTime.now, :order_placed_after => odfn).invalid?
  end
  
end
