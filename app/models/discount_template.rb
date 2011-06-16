class DiscountTemplate < ActiveRecord::Base
  
  has_many :discounts
  has_many :customers, :through => :discounts
  
  validates :value, :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => false
  validates :discount_type, :inclusion => {:in => ["fixed_amount", "percentage"]}, :allow_nil => false
  validates :customer_criteria, :inclusion => {:in => ["all", "new", "repeat"]}, :allow_nil => false
  
  validates :minimum_order_amount, :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => true
  validates :usage_limit, :numericality => {:greater_than => 0}, :allow_nil => true
  
  validate :percentage_lte_100
  
  attr_accessible :value, :discount_type, :starts_at, :ends_at, :minimum_order_amount, :usage_limit, :customer_criteria
  
  def value_str
    if discount_type.eql? "fixed_amount"
      "$#{value.to_f}"
    else
      "#{value.to_f}%"
    end
  end
  
  private
    def percentage_lte_100
      self.errors.add(:value, " is over 100%") if (discount_type.eql? "percentage") && (value > 100)
    end
end