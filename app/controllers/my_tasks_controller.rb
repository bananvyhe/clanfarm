class MyTasksController < ApplicationController
  before_action :set_user

  def schedule_task
    milliseconds = params[:milliseconds].to_i
    scheduled_time = Time.at(milliseconds / 1000.0).utc.to_s

    # Создание задания и связывание его с пользователем
    task = @user.scheduled_tasks.create(
      name: 'dynamic_task', 
      schedule: scheduled_time, 
      class_name: 'MyTaskWorker', 
      args: ['arg1', 'arg2']
    )

    if task.persisted?
      # Добавление задания в Sidekiq
      Sidekiq.set_schedule(task.name, {
        'at' => scheduled_time,
        'class' => task.class_name,
        'args' => ['arg1', 'arg2']
      })
      render plain: "Task scheduled for #{scheduled_time}"
    else
      render plain: "Failed to schedule task", status: :unprocessable_entity
    end
  end

  def unschedule_task
    task = @user.scheduled_tasks.find_by(name: 'dynamic_task')
    
    if task
      # Удаление задания из базы данных
      task.destroy

      # Удаление задания из Sidekiq
      Sidekiq.remove_schedule(task.name)
      
      render plain: "Task unscheduled"
    else
      render plain: "Task not found", status: :not_found
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end