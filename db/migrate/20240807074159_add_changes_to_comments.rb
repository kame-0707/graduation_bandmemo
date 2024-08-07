class AddChangesToComments < ActiveRecord::Migration[7.1]
  def change
    change_column_null :comments, :group_id, true
  end
end
