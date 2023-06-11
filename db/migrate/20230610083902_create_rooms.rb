class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :room_image
      t.string :room_name
      t.text :description
      t.integer :room_fee
      t.integer :user_id

      t.timestamps
    end
  end
end
