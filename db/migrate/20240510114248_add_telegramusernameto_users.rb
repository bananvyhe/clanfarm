class AddTelegramusernametoUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :telegramusername, :string
  end
end
