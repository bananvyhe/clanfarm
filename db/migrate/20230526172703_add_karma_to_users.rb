class AddKarmaToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :karma, :integer, default: 0, null: false
    add_column :users, :expirience, :bigint, default: 0, null: false
    add_column :users, :dead, :boolean, default: false, null: false
    add_column :users, :pk, :integer, default: 0, null: false
    add_column :users, :cry, :integer, default: 0, null: false
  end
end
