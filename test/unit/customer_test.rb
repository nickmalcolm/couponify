require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
class CustomerMatchingTest < ActiveSupport::TestCase
  
  def setup
    @customer = Factory(:customer, :orders_count => 1)
  end
  
  test "customer matches empty template" do
    #0% discount for all customers
    assert @customer.matches?(Factory(:discount_template, :value => 0, 
    :customer_criteria => "all", :discount_type => "percentage"))
  end
end