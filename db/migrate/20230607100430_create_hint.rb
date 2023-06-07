class CreateHint < ActiveRecord::Migration[7.0]
  def change
    create_table :hints do |t|
      t.references :question, null: false, foreign_key: true
      t.text :text
      
      t.timestamps
    end
  end
end
