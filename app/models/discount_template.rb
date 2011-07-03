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
  
  attr_accessible :value, :discount_type, :starts_at, :ends_at, :title,
                  :minimum_order_amount, :usage_limit, :customer_criteria,
                  :order_placed_before, :order_placed_after, :shop_id, :shop
                  
  def as_json(options={})
    hash = Hash.new
    hash[:title] = title
    hash[:all_day] = true
    hash[:start] = order_placed_after
    hash[:end] = order_placed_before
    hash[:url] = "discount_templates/#{id}/"
    hash[:id] = id
    return hash
  end
  
  private
    def percentage_lte_100
      self.errors.add(:value, " is over 100%") if (discount_type.eql? "percentage") && (value > 100)
    end
    
    def nils_to_defaults
      self.starts_at ||= DateTime.now.utc
      self.order_placed_after ||= DateTime.now.utc
      self.minimum_order_amount ||= 0.00
      true
    end
    
    def ends_after_starts
      self.errors.add(:ends_at, "is before the start date") if (!ends_at.nil? && (ends_at < starts_at))
      self.errors.add(:order_placed_before, "is before the start date") if (!order_placed_before.nil? && (order_placed_before < order_placed_after))
    end
    
    def dates_to_midnight
      self.starts_at  = self.starts_at.utc.beginning_of_day
      self.order_placed_after  = self.order_placed_after.utc.beginning_of_day
      
      self.ends_at  = self.ends_at.utc.end_of_day unless self.ends_at.nil?
      self.order_placed_before = self.order_placed_before.utc.end_of_day unless self.order_placed_before.nil?
    end
end