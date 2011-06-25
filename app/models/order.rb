class Order < ActiveRecord::Base
  
  validates :email, :presence => true
  validates :total_price, :presence => true, :numericality => true
  validates :shopify_id, :presence => true, :numericality => true
  validates :total_line_items_price, :presence => true, :numericality => true
  validates :subtotal_price, :presence => true, :numericality => true
  validates :buyer_accepts_marketing, :presence => true
  validates :customer_id, :presence => true, :numericality => true
  
  belongs_to :customer, :primary_key => :shopify_id
  
  attr_accessible :email, :total_price, :shopify_id, :total_line_items_price, :subtotal_price,
                  :buyer_accepts_marketing, :customer_id
                                                        
end                                                     
