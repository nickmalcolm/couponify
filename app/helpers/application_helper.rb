module ApplicationHelper
  
  def template_descr(dt)
    d  = "Between <strong>" + (dt.order_placed_after.nil? ? "now " : dt.order_placed_after.strftime("%d %b %y"))
    d += "</strong> and <strong>" + (dt.order_placed_before.nil? ? "forever " : dt.order_placed_before.strftime("%d %b %y"))  + "</strong>"
    d += " send <strong>#{dt.customer_criteria} customers</strong>"
    
    if dt.minimum_order_amount.to_i > 0
       d += " who place <strong> orders over #{dt.minimum_order_amount}USD </strong>"
    end
    
    d += " a <strong>#{dt.value_str}</strong> discount code. "
    d += "This code can be used between <strong>" + (dt.starts_at.nil? ? "now " : dt.starts_at.strftime("%d %b %y"))
    d += "</strong> and <strong>" + (dt.ends_at.nil? ? "forever " : dt.ends_at.strftime("%d %b %y")) + "</strong>"
    d += " on <strong> "
    d += dt.usage_limit.nil? ? " one order" : "at most #{pluralize(dt.usage_limit, "order")}"
    d += "</strong>."
  end
  
  def amount_as_currency(amount, shop)
    shop.money_with_currency_format.gsub("{{amount}}", pad_number(amount))
  end
  
  def pad_number(number, min_decimals=2)
    s = "%g" % number
    decimals = (s[/\.(\d+)/,1] || "").length
    s << "." if decimals == 0
    s << "0"*[0,min_decimals-decimals].max
  end
  
end
