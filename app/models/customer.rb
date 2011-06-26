class Customer < ActiveRecord::Base
  
  belongs_to :shop
  
  validates :shop, :presence => true
  validates :email, :presence => true
  validates :shopify_id, :presence => true
  
  attr_accessible :orders_count, :shop, :shopify_id, :email
  
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
