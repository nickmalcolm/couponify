class Customer < ActiveRecord::Base
  
  belongs_to :shop
  
  validates :shop, :presence => true
  validates :email, :presence => true
  validates :shopify_id, :presence => true, :uniqueness => true
  
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
  
  def self.new_from_shopify(shopify_customer, shop_id)
    a = shopify_customer.attributes
    
    c = Customer.new(a)
    c.accepts_marketing = a["accepts_marketing"]
    c.shopify_id = a["id"]
    c.first_name = a["first_name"]
    c.last_name = a["last_name"]
    c.total_spent = a["total_spent"]
    c.shop_id = shop_id
    c
  end
  
end
