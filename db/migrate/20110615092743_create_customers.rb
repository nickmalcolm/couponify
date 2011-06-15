class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :email
      t.boolean :accepts_marketing
      t.integer :orders_count
      t.integer :shopify_id
      t.string :first_name
      t.string :last_name
      t.float :total_spent

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
