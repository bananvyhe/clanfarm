Rails.application.config.after_initialize do
  ScheduledTask.includes(:user).find_each do |task|
    schedule = {
      'at' => task.schedule,
      'class' => task.class_name,
      'args' => [task.uniqid, task.text, task.telusname]  
    }
    Sidekiq.set_schedule(task.name, schedule)
  end
end