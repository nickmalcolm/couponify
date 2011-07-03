class Discount < ActiveRecord::Base
  
  belongs_to :shop
  belongs_to :customer
  belongs_to :discount_template
  
  validates :customer, :presence => true
  validates :discount_template, :presence => true
  validates_uniqueness_of :code, :scope => :customer_id
  validates :shop, :presence => true
  
  scope :used, where("used = ?", true)
  scope :unused, where("used IS NOT true")
  
  def initialize(*args)
    super(*args)
    
    o = [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten;  
    self.code = (0..9).map{ o[rand(o.length)] }.join;
  end
  
end
