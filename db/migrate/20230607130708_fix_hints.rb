class FixHints < ActiveRecord::Migration[7.0]
  def change
    remove_column :hints, :state
    add_column :games, :hints_count, :integer, default: 0
  end
end
