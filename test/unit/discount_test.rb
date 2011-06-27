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
  
end
