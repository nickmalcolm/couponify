class ChangeFloatsToDecimals < ActiveRecord::Migration
  def self.up
    change_column :customers, :total_spent, :decimal, :precision => 16, :scale => 2
    
    change_column :discount_templates, :value, :decimal, :precision => 16, :scale => 2
    change_column :discount_templates, :minimum_order_amount, :decimal, :precision => 16, :scale => 2
    
    change_column :orders, :total_price, :decimal, :precision => 16, :scale => 2
    change_column :orders, :total_discounts, :decimal, :precision => 16, :scale => 2
    change_column :orders, :total_line_items_price, :decimal, :precision => 16, :scale => 2
    change_column :orders, :subtotal_price, :decimal, :precision => 16, :scale => 2
  end

  def self.down
    change_column :customers, :total_spent, :float
    
    change_column :discount_templates, :value, :float
    change_column :discount_templates, :minimum_order_amount, :float
    
    change_column :orders, :total_price, :float
    change_column :orders, :total_discounts, :float
    change_column :orders, :total_line_items_price, :float
    change_column :orders, :subtotal_price, :float
  end
end
