class AddTitleToDiscountTemplates < ActiveRecord::Migration
  def self.up
    add_column :discount_templates, :title, :string
  end

  def self.down
    remove_column :discount_templates, :title
  end
end
