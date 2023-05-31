class AddQuestionRefToGame < ActiveRecord::Migration[7.0]
  def change
    add_reference :games, :question, null: true, foreign_key: true
  end
end
