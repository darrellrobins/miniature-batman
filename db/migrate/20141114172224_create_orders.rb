class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :check_in
      t.date :check_out

      t.timestamps
    end
  end
end
