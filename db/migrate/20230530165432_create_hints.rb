class CreateHints < ActiveRecord::Migration[7.0]
  def change
    create_table :hints do |t|
      t.string :text
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
