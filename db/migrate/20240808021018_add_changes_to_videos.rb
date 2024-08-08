class AddChangesToVideos < ActiveRecord::Migration[7.1]
  def change
    change_column_null :videos, :group_id, true
  end
end
