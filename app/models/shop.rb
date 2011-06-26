class Shop < ActiveRecord::Base
  
  validates_presence_of :domain
  has_many :customers
  has_many :discounts
  has_many :discount_templates
  has_many :orders
  
  def site
    "https://"+ShopifyAPI::Session.api_key+":"+api_password+"@"+domain+"/admin"
  end
  
end
