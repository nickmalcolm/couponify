class Customer < ActiveRecord::Base
  
  validates :email, :presence => true
  
  attr_accessible :orders_count
  
  def matches?(dt)
    case dt.customer_criteria
    when "all"
      true
    when "new"
      orders_count == 1
    when "repeat"
      orders_count > 1
    end
  end
  
end
