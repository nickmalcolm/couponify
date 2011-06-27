class Shop < ActiveRecord::Base
  
  validates_presence_of :domain
  has_many :customers
  has_many :discounts
  has_many :discount_templates
  has_many :orders
  
  def site
    "https://"+ShopifyAPI::Session.api_key+":"+api_password+"@"+domain+"/admin"
  end
  
  def update_from_shopify
    shopify_api_connection
    shopify_shop = ShopifyAPI::Shop.current
    
    self.currency = shopify_shop.currency
    self.money_with_currency_format = shopify_shop.money_with_currency_format
    save!
  end
  
  def shopify_api_connection
    ShopifyAPI::Base.site = self.site
  end
  
end
