class CreateGame < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.number :status
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
