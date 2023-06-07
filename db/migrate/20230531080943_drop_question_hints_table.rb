class DropQuestionHintsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :question_hints
  end

  def down
    create_table :question_hints do |t|
      t.integer "question_id", null: false
      t.text "body"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    add_index :question_hints, :question_id
    add_foreign_key :question_hints, :questions
  end
end