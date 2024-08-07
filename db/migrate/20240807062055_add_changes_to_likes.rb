class AddChangesToLikes < ActiveRecord::Migration[7.1]
  def change
    change_column_null :likes, :group_id, true
  end
end
