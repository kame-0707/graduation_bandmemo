class RenameLongitudeColumnToSpot < ActiveRecord::Migration[7.1]
  def change
    rename_column :spots, :longitude, :lng
  end
end
