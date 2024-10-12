class AddSwitchValueToScheduledTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :scheduled_tasks, :switch_value, :boolean, default: false, null: false
  end
end
