class CreateScheduledTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :scheduled_tasks do |t|
      t.string :name
      t.string :schedule
      t.string :class_name
      t.text :args
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
