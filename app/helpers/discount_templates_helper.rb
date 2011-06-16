module DiscountTemplatesHelper
  
  def long_description(dt)
    d =  dt.value_str+", "
    d += "Orders equal to or above $#{dt.minimum_order_amount.to_i}, " if dt.minimum_order_amount.to_i > 0
    d += "Starts "+dt.starts_at.strftime("%b %d, ") unless dt.starts_at.nil?
    d += "Ends "+dt.ends_at.strftime("%b %d, ") unless dt.ends_at.nil?
    d += "Can be used #{pluralize(dt.usage_limit, "time")}" if dt.usage_limit.to_i > 0
    d
  end
  
end
