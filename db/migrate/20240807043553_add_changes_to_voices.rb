class AddChangesToVoices < ActiveRecord::Migration[7.1]
  def change
    change_column_null :voices, :group_id, true
  end
end
