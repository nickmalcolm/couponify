class AddUsedToDiscounts < ActiveRecord::Migration
  def self.up
    add_column :discounts, :used, :boolean
  end

  def self.down
    remove_column :discounts, :used
  end
end
