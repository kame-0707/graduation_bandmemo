class CreateContents < ActiveRecord::Migration[7.1]
  def change
    create_table :contents do |t|
      t.text :original
      t.text :summary

      t.timestamps
    end
  end
end
