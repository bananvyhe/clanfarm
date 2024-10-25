class AddVacanAndPubToScheduledTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :scheduled_tasks, :vacan, :integer, default: 1, null: false
    add_column :scheduled_tasks, :pub, :boolean, default: false, null: false
  end
end
