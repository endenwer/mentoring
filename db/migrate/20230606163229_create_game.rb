class CreateGame < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :state, default: 0
      t.belongs_to :question, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
