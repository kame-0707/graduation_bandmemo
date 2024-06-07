class CreateSummaries < ActiveRecord::Migration[7.1]
  def change
    create_table :summaries do |t|
      t.text :content
      t.text :summary
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
