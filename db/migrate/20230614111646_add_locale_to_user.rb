class AddLocaleToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :locale, :string, null: false
  end
end
