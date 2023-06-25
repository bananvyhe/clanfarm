class ChangeDefAvcp < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :avcpoints, :integer, default: 5
     
  end

  def down
    change_column :users, :avcpoints 
    
  end
end
