class AddChangesToSummaries2 < ActiveRecord::Migration[7.1]
  def change
    change_column_null :summaries, :group_id, true
    change_column_null :summaries, :user_id, false
  end
end
