class CreateDiscountTemplates < ActiveRecord::Migration
  def self.up
    create_table :discount_templates do |t|
      t.float :value
      t.string :type
      t.datetime :starts_at
      t.datetime :ends_at
      t.float :minimum_order_amount
      t.integer :usage_limit

      t.timestamps
    end
  end

  def self.down
    drop_table :discount_templates
  end
end
