class RenameStartsAtEndsAtForDiscountTemplates < ActiveRecord::Migration
  def self.up
    rename_column :discount_templates, :starts_at,  :order_placed_after
    rename_column :discount_templates, :ends_at,    :order_placed_before
    rename_column :discount_templates, :valid_starts_at, :starts_at
    rename_column :discount_templates, :valid_ends_at, :ends_at
  end

  def self.down
    rename_column :discount_templates, :ends_at,    :valid_ends_at
    rename_column :discount_templates, :starts_at,  :valid_starts_at
    rename_column :discount_templates, :order_placed_before, :ends_at
    rename_column :discount_templates, :order_placed_after, :starts_at
  end
end
