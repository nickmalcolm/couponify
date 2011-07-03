class AddExpiresAtToDiscounts < ActiveRecord::Migration
  def self.up
    add_column :discounts, :expires_at, :datetime
  end

  def self.down
    remove_column :discounts, :expires_at
  end
end
