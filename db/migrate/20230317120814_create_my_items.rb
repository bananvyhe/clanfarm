class CreateMyItems < ActiveRecord::Migration[7.0]
  def change
    create_table :my_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :listitem, null: false, foreign_key: true
      t.bigint :qty, default: 0
      t.integer :position 

      t.timestamps
    end
  end
end
