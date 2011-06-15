class DiscountTemplate < ActiveRecord::Base
  
  has_many :discounts
  has_many :customers, :through => :discounts
  
  validates :value, :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => false
  validates :type, :inclusion => {:in => ["fixed_amount", "percentage"]}, :allow_nil => false
  validates :minimum_order_amount, :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => true
  validates :usage_limit, :numericality => {:greater_than => 0}, :allow_nil => true
  
  validate :percentage_lte_100
  
  attr_accessible :value, :type, :starts_at, :ends_at, :minimum_order_amount, :usage_limit
  
  
  private
    def percentage_lte_100
      if type.eql? "percentage"
        return value <= 100
      end
    end
end