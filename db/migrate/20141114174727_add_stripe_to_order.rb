class AddStripeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :stripe_token, :string
    add_column :orders, :user_id, :integer
    add_column :orders, :room_id, :integer
  end
end
