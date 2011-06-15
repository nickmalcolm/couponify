class AddCustomerToDiscounts < ActiveRecord::Migration
  def self.up
    add_column :discounts, :customer_id, :integer
  end

  def self.down
    remove_column :discounts, :customer_id
  end
end
