class Order < ActiveRecord::Base
  
  validates :email, :presence => true
  validates :total_price, :presence => true, :numericality => true
  validates :shopify_id, :presence => true, :numericality => true
  validates :total_line_items_price, :presence => true, :numericality => true
  validates :subtotal_price, :presence => true, :numericality => true
  validates :buyer_accepts_marketing, :presence => true
  validates :shopify_customer_id, :presence => true, :numericality => true
  
  belongs_to :customer, :foreign_key => :shopify_customer_id, :primary_key => :shopify_id
  
  attr_accessible :email, :total_price, :shopify_id, :total_line_items_price, :subtotal_price,
                  :buyer_accepts_marketing, :shopify_customer_id
                  
  def matches?(dt)
    (dt.order_placed_after  < created_at) &&
    (dt.order_placed_before.nil? ? true : (dt.order_placed_before > created_at) ) &&
    (dt.minimum_order_amount.nil? ? true : (dt.minimum_order_amount < total_price) ) &&
    (dt.customer_criteria.eql? "all")
  end
                                                        
end                                                     
