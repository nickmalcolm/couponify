class Shop < ActiveRecord::Base
  
  validates_presence_of :domain
  
  def site
    "https://"+ShopifyAPI::Session.api_key+":"+api_password+"@"+domain+"/admin"
  end
  
end
