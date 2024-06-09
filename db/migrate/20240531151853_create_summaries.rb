class CreateSummaries < ActiveRecord::Migration[7.1]
  def change
    create_table :summaries do |t|
      t.text :title, null: false
      t.text :content, null: false
      t.text :summary, null: false

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
