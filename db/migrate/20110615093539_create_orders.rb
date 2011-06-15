class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.float :total_price
      t.float :total_discounts
      t.integer :shopify_id
      t.float :total_line_items_price
      t.float :subtotal_price
      t.boolean :buyer_accepts_marketing
      t.integer :customer_id
      t.string :discount_code

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
