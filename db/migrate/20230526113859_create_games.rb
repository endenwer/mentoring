class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.string :hints_count
      t.string :number
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
