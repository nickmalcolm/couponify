require 'test_helper'

class DiscountTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def setup
    @customer = Factory(:customer)
    @shop = Factory(:shop)
    @dt = Factory(:discount_template)
  end
  
  test "can't have blank discount" do
    assert Discount.new.invalid?
  end
  
  test "can create discount with auto code" do
    d = Discount.create!(:customer => @customer, :shop => @shop, :discount_template => @dt)
    assert_equal 10, d.code.size
  end
  
  test "can't make a duplicate code per customer" do
    d1 = Discount.create!(:customer => @customer, :shop => @shop, :discount_template => @dt)
    code = d1.code
    d2 = Discount.create!(:customer => @customer, :shop => @shop, :discount_template => @dt)
    d2.code = code
    assert d2.invalid?
  end
  
  test "can have duplicate across customers" do
    d1 = Discount.create!(:customer => @customer, :shop => @shop, :discount_template => @dt)
    code = d1.code
    d2 = Discount.create!(:customer => Factory(:customer), :shop => @shop, :discount_template => @dt)
    d2.code = code
    assert d2.valid?
  end
  
  test "scope for unused" do
    d1 = Factory(:discount)
    d2 = Factory(:discount)
    
    assert Discount.unused.include? d1
    assert Discount.unused.include? d2
    
    d1.used = true
    d1.save!
    
    assert !(Discount.unused.include? d1)
    assert Discount.unused.include? d2
  end  
  
  test "scope for used" do
    d1 = Factory(:discount)
    d2 = Factory(:discount)
    
    assert !(Discount.used.include? d1)
    assert !(Discount.used.include? d2)
    
    d1.used = true
    d1.save!
    
    assert Discount.used.include? d1
    assert !(Discount.used.include? d2)
  end
    
  
end
