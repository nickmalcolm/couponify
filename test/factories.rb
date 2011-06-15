Factory.define :customer do |c|
  c.email { Faker::Internet.email }
end

Factory.define :fake_customer, :parent => :customer do |c|
  c.first_name { Faker::Name.first_name }
  c.last_name { Faker::Name.last_name }
  c.sequence(:shopify_id) { |n| n }
  c.accepts_marketing true
  c.orders_count rand(5)
  c.total_spent rand(100.00)
end

Factory.define :discount do |d|
  d.association :customer, :factory => :fake_customer
end

Factory.define :discount_template do |dt|
  dt.value rand(100.00)
  dt.type "percentage"
  dt.minimum_order_amount rand(100.00)
end