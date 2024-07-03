class AddDetailsToVoices < ActiveRecord::Migration[7.1]
  def change
    add_reference :voices, :group, null: false, foreign_key: true
  end
end
