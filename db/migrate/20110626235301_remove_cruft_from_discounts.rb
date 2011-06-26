class RemoveCruftFromDiscounts < ActiveRecord::Migration
  def self.up
    remove_column :discounts, :value
    remove_column :discounts, :type
    remove_column :discounts, :starts_at
    remove_column :discounts, :ends_at
    remove_column :discounts, :minimum_order_amount
    remove_column :discounts, :usage_limit
  end

  def self.down
    add_column :discounts, :value, :decimal, :precision => 16, :scale => 2
    add_column :discounts, :type, :string
    add_column :discounts, :starts_at, :datetime
    add_column :discounts, :ends_at, :datetime
    add_column :discounts, :minimum_order_amount, :decimal, :precision => 16, :scale => 2
    add_column :discounts, :usage_limit, :integer
  end
end
