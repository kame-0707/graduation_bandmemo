class AddChangesToSpots < ActiveRecord::Migration[7.1]
  def change
    change_column_null :spots, :group_id, true
  end
end
