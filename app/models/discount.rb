class Discount < ActiveRecord::Base
  
  belongs_to :customer
  belongs_to :discount_template
  
  validates_presence_of :customer
  validates_uniqueness_of :code, :scope => :customer_id
  
  attr_accessible :customer
  
  def initialize(*args)
    super(*args)
    
    o = [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten;  
    self.code = (0..9).map{ o[rand(o.length)] }.join;
  end
  
end
