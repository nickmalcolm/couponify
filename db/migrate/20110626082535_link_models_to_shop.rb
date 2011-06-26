class LinkModelsToShop < ActiveRecord::Migration
  def self.up
    add_column :customers, :shop_id, :integer
    add_column :discounts, :shop_id, :integer
    add_column :discount_templates, :shop_id, :integer
    add_column :orders, :shop_id, :integer
  end

  def self.down
    remove_column :customers, :shop_id
    remove_column :discounts, :shop_id
    remove_column :discount_templates
    remove_column :orders, :shop_id
  end
end
