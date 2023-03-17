class CreateDropitems < ActiveRecord::Migration[7.0]
  def change
    create_table :dropitems do |t|
      t.references :mob, null: false, foreign_key: true
      t.references :listitem, null: false, foreign_key: true
      t.float :modifyrate

      t.timestamps
    end 
  end
end
