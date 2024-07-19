class RenameLatitudeColumnToSpot < ActiveRecord::Migration[7.1]
  def change
    rename_column :spots, :latitude, :lat
  end
end
