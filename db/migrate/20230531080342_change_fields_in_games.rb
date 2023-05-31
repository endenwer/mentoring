class ChangeFieldsInGames < ActiveRecord::Migration[7.0]
  def change
    change_column :games, :hints_count, :integer
  end
end