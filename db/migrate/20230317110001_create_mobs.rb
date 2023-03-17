class CreateMobs < ActiveRecord::Migration[7.0]
  def change
    create_table :mobs do |t|
      t.string :name
      t.string :hp
      t.string :loa

      t.timestamps
    end
  end
end
