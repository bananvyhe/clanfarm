class RemoveUniqueIndexFromNewsLink < ActiveRecord::Migration[7.0]
  def change
  	remove_index :news, :link
  end
end
