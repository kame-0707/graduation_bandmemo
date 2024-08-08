class AddChangesToVoices2 < ActiveRecord::Migration[7.1]
  def change
    change_column_null :voices, :user_id, false
  end
end
