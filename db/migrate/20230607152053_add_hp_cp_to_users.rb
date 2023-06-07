class AddHpCpToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :avcpoints, :integer, default: 0
    add_column :users, :health, :integer, default: 240
  end
end
