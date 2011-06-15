require 'test_helper'

class DiscountTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def setup
    @customer = Factory(:customer)
  end
  
  test "can create discount with auto code" do
    d = Discount.create!(:customer => @customer)
    assert_equal 10, d.code.size
  end
  
  test "can't make a duplicate code per customer" do
    d1 = Discount.create!(:customer => @customer)
    code = d1.code
    d2 = Discount.create!(:customer => @customer)
    d2.code = code
    assert d2.invalid?
  end
  
  test "can have duplicate across customers" do
    d1 = Discount.create!(:customer => @customer)
    code = d1.code
    d2 = Discount.create!(:customer => Factory(:customer))
    d2.code = code
    assert d2.valid?
  end
  
end
