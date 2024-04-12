class AddOnlineFieldToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :online_field, :datetime
  end
end
