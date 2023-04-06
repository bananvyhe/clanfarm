class ChangeRoleSetup < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :role, :integer, default: 0, null: false
  end

  def down
    change_column :users, :role, :integer
  end
end
