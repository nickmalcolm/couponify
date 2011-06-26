require 'test_helper'

class DiscountTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def setup
    @customer = Factory(:customer)
    @shop = Factory(:shop)
  end
  
  test "can't have blank discount" do
    assert Discount.new.invalid?
  end
  
  test "can create discount with auto code" do
    d = Discount.create!(:customer => @customer, :shop => @shop)
    assert_equal 10, d.code.size
  end
  
  test "can't make a duplicate code per customer" do
    d1 = Discount.create!(:customer => @customer, :shop => @shop)
    code = d1.code
    d2 = Discount.create!(:customer => @customer, :shop => @shop)
    d2.code = code
    assert d2.invalid?
  end
  
  test "can have duplicate across customers" do
    d1 = Discount.create!(:customer => @customer, :shop => @shop)
    code = d1.code
    d2 = Discount.create!(:customer => Factory(:customer), :shop => @shop)
    d2.code = code
    assert d2.valid?
  end
  
end
