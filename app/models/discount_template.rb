class DiscountTemplate < ActiveRecord::Base
  
  has_many :discounts
  has_many :customers, :through => :discounts
  
  validates :value, :numericality => {:greater_than => 0}, :allow_nil => false
  validates :type, :inclusion => {:in => ["fixed_amount", "percentage"]}, :allow_nil => false
  validates :minimum_order_amount, :numericality => true, :allow_nil => true
  validates :usage_limit, :numericality => {:greater_than => 1}, :allow_nil => true
  
  attr_accessible :value, :type, :starts_at, :ends_at, :minimum_order_amount, :usage_limit
                   
end