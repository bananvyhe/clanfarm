class CreateMobUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :mob_users do |t|
      t.boolean :death
      t.integer :damagedeal, default: 0
      t.references :mob, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
