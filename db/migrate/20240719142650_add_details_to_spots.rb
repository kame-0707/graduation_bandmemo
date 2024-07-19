class AddDetailsToSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :spots, :start_datetime, :datetime
  end
end
