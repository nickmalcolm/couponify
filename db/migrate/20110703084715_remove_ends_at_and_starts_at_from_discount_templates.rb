class RemoveEndsAtAndStartsAtFromDiscountTemplates < ActiveRecord::Migration
  def self.up
    remove_column :discount_templates, :starts_at
    remove_column :discount_templates, :ends_at
  end

  def self.down
    add_column :discount_templates, :starts_at, :datetime
    add_column :discount_templates, :ends_at, :datetime
  end
end
