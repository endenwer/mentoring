class CreateAnswer < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string :text
      t.belongs_to :question, null: true, foreign_key: true

      t.timestamps
    end
  end
end
