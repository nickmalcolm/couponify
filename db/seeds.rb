require 'faker'

#Make a shop
s = Shop.new
s.domain        = "reichert-corwin-and-boehm5403.myshopify.com"
s.api_password  = "63ec5e74d581bfaa249530969da6f57e"
s.currency      = "JPY"
s.money_with_currency_format = "&#165;{{amount_no_decimals}} JPY"
s.save!

#Give it some Promotions
14.times do
  dt = DiscountTemplate.new(:shop => s)
  dt.title                = Faker::Lorem.words.join(" ").capitalize
  dt.customer_criteria    = %w(all new repeat).rand
  dt.value                = [5, 10, 25, 50].rand
  dt.discount_type        = %w(percentage fixed_amount).rand
  dt.order_placed_after   = (rand(120)-60).days.ago
  dt.order_placed_before  = dt.order_placed_after + rand(9)+1.days
  dt.days_valid           = rand(31)
  dt.valid_type           = %w(after_generated after_end_date).rand
  dt.save!
end 

#Make at least 100 customers
(rand(100)+100).times do |i|
  c = Customer.new(:shop => s)
  c.email                 = Faker::Internet.email
  c.shopify_id            = i
  c.save!
end

#Add some orders for all customers,
# some of whom may place > 1 order
(Customer.count+rand(Customer.count)).times do |i|
  o = Order.new(:shop => s)
  o.created_at                = rand(31).days.ago
  o.email                     = Faker::Internet.email
  o.shopify_id                = i
  price                       = (rand*100+1).round(2)
  o.total_price               = price
  o.total_line_items_price    = price
  o.subtotal_price            = price
  o.buyer_accepts_marketing   = true
  o.customer                  = Customer.all.rand
  o.save!
  
  c = o.customer
  c.orders_count              = c.orders_count.to_i + 1
  c.total_spent               ||= 0.00
  c.total_spent               = c.total_spent + price
  c.save!
end

#Generate discounts
DiscountTemplate.all.each do |dt|
  Order.all.each do |o|
    #Make the discount, if the order matches
    # the template
    disc = dt.discount_for_order(o)
    
    unless disc.nil? 
      #Generated at dates will be unrelated
      #to order dates
    
      diff = disc.created_at - o.created_at
      disc.created_at = o.created_at
    
      dt = disc.discount_template
      unless dt.days_valid.nil?
        if dt.valid_type.eql? "after_end_date"
          disc.expires_at = (dt.order_placed_before + dt.days_valid.days).end_of_day
        else
          disc.expires_at = (disc.created_at + dt.days_valid.days).end_of_day
        end
      end
      
      disc.save!
      
    end
  end
end