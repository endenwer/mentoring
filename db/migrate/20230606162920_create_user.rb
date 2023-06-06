class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :telegram_id, null: false
      t.string :first_name, null: false
      t.string :username
      t.string :last_name

      t.timestamps
    end
  end
end
