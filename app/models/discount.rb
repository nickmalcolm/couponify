class Discount < ActiveRecord::Base
  
  belongs_to :shop
  belongs_to :customer
  belongs_to :discount_template
  
  validates_presence_of :customer
  validates_presence_of :discount_template
  validates_uniqueness_of :code, :scope => :customer_id
  validates :shop, :presence => true
  
  attr_accessible :customer, :shop, :discount_template
  
  def initialize(*args)
    super(*args)
    
    o = [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten;  
    self.code = (0..9).map{ o[rand(o.length)] }.join;
  end
  
end
