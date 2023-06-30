class RemoveAnswersTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :answers

    add_column :questions, :answer, :string, null: false
  end
end
