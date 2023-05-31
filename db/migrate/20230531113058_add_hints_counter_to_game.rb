class AddHintsCounterToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :hints_count, :integer
  end
end
