module DiscountTemplatesHelper
  
  def long_description(dt)
    d =  "Give <strong>#{dt.customer_criteria} customers</strong> who place <strong>"
    d += ((dt.minimum_order_amount.to_i > 0) ? "orders over #{dt.minimum_order_amount}USD " : "any order ") 
    d += "</strong>"
    d += "between <strong>" + (dt.order_placed_after.nil? ? "now " : dt.order_placed_after.strftime("%d %b %y"))
    d += "</strong> and <strong>" + (dt.order_placed_before.nil? ? "forever " : dt.order_placed_before.strftime("%d %b %y"))
    d += "</strong> a discount of <strong>#{dt.value_str}</strong> "
    d += "to be used on <strong>at most #{dt.usage_limit} #{pluralize(dt.usage_limit, "order")}</strong> "
    d += "placed between <strong>" + (dt.starts_at.nil? ? "now " : dt.starts_at.strftime("%d %b %y"))
    d += "</strong> and <strong>" + (dt.ends_at.nil? ? "forever " : dt.ends_at.strftime("%d %b %y"))
  end
  
end
