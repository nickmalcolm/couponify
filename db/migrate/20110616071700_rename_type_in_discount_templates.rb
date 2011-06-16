class RenameTypeInDiscountTemplates < ActiveRecord::Migration
  def self.up
    rename_column :discount_templates, :type, :discount_type
  end

  def self.down
    rename_column :discount_templates, :discount_type, :type
  end
end
