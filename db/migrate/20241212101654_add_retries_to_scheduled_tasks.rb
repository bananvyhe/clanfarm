class AddRetriesToScheduledTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :scheduled_tasks, :retries, :integer
  end
end
