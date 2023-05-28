class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :body
      t.string :answer
      t.string :text

      t.timestamps
    end
  end
end
