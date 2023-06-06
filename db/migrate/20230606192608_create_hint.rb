class CreateHint < ActiveRecord::Migration[7.0]
  def change
    create_table :hints do |t|
      t.string :text, null: false
      t.belongs_to :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
