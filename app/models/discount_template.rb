class DiscountTemplate < ActiveRecord::Base
  
  belongs_to :shop
  has_many :discounts
  has_many :customers, :through => :discounts
  
  validates :shop, :presence => true
  validates :value, :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => false
  validates :discount_type, :inclusion => {:in => ["fixed_amount", "percentage"]}, :allow_nil => false
  validates :customer_criteria, :inclusion => {:in => ["all", "new", "repeat"]}, :allow_nil => false
  
  validates :minimum_order_amount, :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => false
  validates :usage_limit, :numericality => {:greater_than => 0}, :allow_nil => true
  
  validates :valid_type, :inclusion => {:in => ["after_generated", "after_end_date"]}, :allow_nil => true
  validates :days_valid, :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => true
  
  validate :percentage_lte_100
  validate :ends_after_starts
  
  before_validation :nils_to_defaults
  before_validation :dates_to_midnight
  
  attr_accessible :value, :discount_type, :title, :days_valid, :valid_type,
                  :minimum_order_amount, :usage_limit, :customer_criteria,
                  :order_placed_before, :order_placed_after, :shop_id, :shop
                  
  def as_json(options={})
    hash = Hash.new
    hash[:title] = (title.nil? ? "" : title)
    hash[:all_day] = true
    hash[:start] = order_placed_after
    hash[:end] = order_placed_before
    hash[:url] = "discount_templates/#{id}/"
    hash[:id] = id
    return hash
  end
  
  def discount_for_order(order)
    if order.matches? self
      
      d = Discount.new
      
      d.customer = order.customer
      d.discount_template = self
      d.shop = self.shop
      
      unless days_valid.nil?
        if valid_type.eql? "after_end_date"
          d.expires_at = (order_placed_before + days_valid.days).end_of_day
        else
          d.expires_at = days_valid.days.from_now.end_of_day
        end
      end
      
      d.save!
      
      discounts << d
      d
    end
  end
  
  private
    def percentage_lte_100
      self.errors.add(:value, " is over 100%") if (discount_type.eql? "percentage") && (value > 100)
    end
    
    def nils_to_defaults
      self.order_placed_after ||= DateTime.now.utc
      self.minimum_order_amount ||= 0.00
      true
    end
    
    def ends_after_starts
      self.errors.add(:order_placed_before, "is before the start date") if (!order_placed_before.nil? && (order_placed_before < order_placed_after))
    end
    
    def dates_to_midnight
      self.order_placed_after  = self.order_placed_after.utc.beginning_of_day
      
      unless self.order_placed_before.nil?
        self.order_placed_before = self.order_placed_before.utc.end_of_day 
      else 
        self.order_placed_before = self.order_placed_after.end_of_day
      end
    end
end