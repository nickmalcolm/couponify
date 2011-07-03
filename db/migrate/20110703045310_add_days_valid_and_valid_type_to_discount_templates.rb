class AddDaysValidAndValidTypeToDiscountTemplates < ActiveRecord::Migration
  def self.up
    add_column :discount_templates, :days_valid, :integer
    add_column :discount_templates, :valid_type, :string
  end

  def self.down
    remove_column :discount_templates, :valid_type
    remove_column :discount_templates, :days_valid
  end
end
