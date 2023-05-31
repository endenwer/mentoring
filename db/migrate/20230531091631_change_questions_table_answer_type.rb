class ChangeQuestionsTableAnswerType < ActiveRecord::Migration[7.0]
  def change
    change_column :questions, :answer, :text
  end
end
