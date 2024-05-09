class AddTelegramidToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :telegramid, :integer
  end
end
