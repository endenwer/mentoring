class CreateQuestionHints < ActiveRecord::Migration[7.0]
  def change
    create_table :question_hints do |t|
      t.references :question, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
