class AddCombatToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :cpoints, :integer, default: 5, null: false
  end
end
