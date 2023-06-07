class ChangeQuestionsTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :body, :text
    change_column :questions, :text, :text
  end
end
