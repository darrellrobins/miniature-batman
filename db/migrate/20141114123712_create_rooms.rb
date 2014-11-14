class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :price_in_pence
      t.string :name, limit: 64
      t.text :description
      t.date :availability
      t.string :address, limit: 256
      t.float :latitude
      t.float :longitude
      t.string :phone_no
      t.integer :no_of_rooms
      t.integer :max_guests
      t.boolean :pets
      t.integer :user_id

      t.timestamps
    end
  end
end
