class AddValidDatesToDiscountTemplates < ActiveRecord::Migration
  def self.up
    add_column :discount_templates, :valid_starts_at, :datetime
    add_column :discount_templates, :valid_ends_at, :datetime
  end

  def self.down
    remove_column :discount_templates, :valid_ends_at
    remove_column :discount_templates, :valid_starts_at
  end
end
