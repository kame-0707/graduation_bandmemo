class CreateSpots < ActiveRecord::Migration[7.1]
  def change
    create_table :spots do |t|
      t.string :registered_title
      t.string :address
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :opening_hours
      t.string :phone_number
      t.string :website
      t.string :place_id

      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
