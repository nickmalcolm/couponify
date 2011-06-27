Factory.define :customer do |c|
  c.email { Faker::Internet.email }
  c.association :shop, :factory => :shop
  c.sequence(:shopify_id) { |n| n }
end

Factory.define :fake_customer, :parent => :customer do |c|
  c.first_name { Faker::Name.first_name }
  c.last_name { Faker::Name.last_name }
  c.accepts_marketing true
  c.orders_count rand(5)
  c.total_spent rand(100.00)
end

Factory.define :discount do |d|
  d.association :customer, :factory => :fake_customer
  d.association :shop, :factory => :shop
end

Factory.define :discount_template do |dt|
  dt.value rand(100.00)
  dt.customer_criteria "repeat"
  dt.discount_type "percentage"
  dt.association :shop, :factory => :shop
end

Factory.define :order do |o|
  o.email "bob@example.com"
  o.total_price 7.00
  o.total_discounts 0
  o.shopify_id 1234
  o.total_line_items_price 7.00
  o.subtotal_price 7.00
  o.buyer_accepts_marketing true
  o.association :shop, :factory => :shop
end

Factory.define :shop do |s|
  s.domain "example.com"
end