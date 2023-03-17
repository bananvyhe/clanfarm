class CreateListitems < ActiveRecord::Migration[7.0]
  def change
    create_table :listitems do |t|
      t.string :title
      t.string :desc
      t.string :item 
      t.float :rate
      t.string :pic
      
      t.timestamps
    end
  end
end
