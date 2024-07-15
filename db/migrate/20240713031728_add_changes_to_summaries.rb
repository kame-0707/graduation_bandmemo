class AddChangesToSummaries < ActiveRecord::Migration[7.1]
  def change
    change_column_null :summaries, :summary, true
  end
end
