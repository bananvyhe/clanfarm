class CreateNews < ActiveRecord::Migration[7.0]
  def change
    create_table :news do |t|
      t.string :pic
      t.string :head
      t.string :date
      t.string :desc
      t.string :biglink
      t.string :fullarticle
      t.string :link

      t.timestamps
    end
    add_index :news, :link, unique: true
  end
end
