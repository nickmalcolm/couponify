class RenameCustomerIdAttributeInOrders < ActiveRecord::Migration
  def self.up
    rename_column :orders, :shopify_customer_id, :customer_id
  end

  def self.down
    rename_column :orders, :customer_id, :shopify_customer_id
  end
end
