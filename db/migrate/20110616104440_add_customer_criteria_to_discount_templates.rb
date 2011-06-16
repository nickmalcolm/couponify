class AddCustomerCriteriaToDiscountTemplates < ActiveRecord::Migration
  def self.up
    add_column :discount_templates, :customer_criteria, :string
  end

  def self.down
    remove_column :discount_templates, :customer_criteria
  end
end
