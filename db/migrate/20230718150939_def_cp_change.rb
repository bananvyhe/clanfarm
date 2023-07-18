class DefCpChange < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :cpoints, :integer, default: 5
     
  end

  def down
    change_column :users, :cpoints 
    
  end
end
