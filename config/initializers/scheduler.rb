Rails.application.config.after_initialize do
  ScheduledTask.includes(:user).find_each do |task|
    schedule = {
      'at' => task.schedule,
      'class' => task.class_name,
      'args' => [task.name, task.args, task.user.telegramid]  
    }
    Sidekiq.set_schedule(task.name, schedule)
  end
end