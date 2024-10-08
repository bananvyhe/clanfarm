class MyTasksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_access_request!, only: [:schedule_task, :unschedule_task]

  def schedule_task
    puts "gssgsgsgs gsgssgsgsgsg sgsgsgsgsgsg"

    # milliseconds = params[:milliseconds].to_i
    # scheduled_time = Time.at(milliseconds / 1000.0).utc.to_s
    # uniqid = params[:uniqid]
    # text = params[:text]
    # # vremya = params[:vremya]
    # # Создание задания и связывание его с пользователем
    # task = @user.scheduled_tasks.create(
    #   name: uniqid,
    #   schedule: scheduled_time,
    #   class_name: 'MyTaskWorker',
    #   args: [ ]
    # )

    # if task.persisted?
    #   # Добавление задания в Sidekiq
    #   Sidekiq.set_schedule(task.name, {
    #     'at' => scheduled_time,
    #     'class' => task.class_name,
    #     'args' => [ ]
    #   })
    #   render plain: "Task scheduled for #{scheduled_time}"
    # else
    #   render plain: "Failed to schedule task", status: :unprocessable_entity
    # end
  end

  def unschedule_task
    # task = @user.scheduled_tasks.find_by(name: 'dynamic_task')
    
    # if task
    #   # Удаление задания из базы данных
    #   task.destroy

    #   # Удаление задания из Sidekiq
    #   Sidekiq.remove_schedule(task.name)
      
    #   render plain: "Task unscheduled"
    # else
    #   render plain: "Task not found", status: :not_found
    # end
  end

  private

  # def set_user
  #   @user = User.find(params[:user_id])
  # end
end