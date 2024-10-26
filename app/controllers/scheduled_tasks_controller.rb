class ScheduledTasksController < ApplicationController
  # skip_before_action :verify_authenticity_token
    require 'sanitize'

  before_action :authorize_access_request!, only: [:schedule_task, :unschedule_task, :shedGet]

  def shedGet
    puts "==----shedGet---=="
puts payload['user_id']
    @schedFind = ScheduledTask.where('user_id = ?', payload['user_id'])
      .select('name', 'schedule', 'args ', 'switch_value', )

  #   user = User.find(payload['user_id'])

    # my_items = user.myItems.includes(:listitem).group(:listitem_id) 
 
    # @schedFind = @schedFind.sorted
      # @invfind = @invfind
    # @invfind = MyItem.where('listitem_id = ?', params[:id]).joins(:user).where('users.id = ?', payload['user_id']) 
      # .select(' qty, listitems.title')
      # .joins(:listitem)
      # .joins(:user)
      # .where('user_id = ?', payload['user_id'])
    puts @schedFind.inspect

    # @invfind.each do |item| 
    #   puts item.listitem.inspect
    # end
    puts "==----shedGet---==" 
    render json: @schedFind
  end

  def switchOff
    
  end
  
  def schedule_task
    puts "gssgsgsgs gsgssgsgsgsg sgsgsgsgsgsg"
    puts params[:milliseconds].to_i

    incomdat = params[:milliseconds].to_i
    puts incomdat.class
    puts params[:uniqid]
    puts params[:text]

    milliseconds = params[:milliseconds].to_i
    scheduled_time = Time.at(milliseconds / 1000.0).utc.iso8601
    puts scheduled_time
 

    uniqid = params[:uniqid]
    if params[:text] != nil
      text = Sanitize.fragment(params[:text])
    else
      text = "без заметки"
    end
    
    # Создание задания и связывание его с пользователем
    task = current_user.scheduled_tasks.create(
      name: uniqid,
      schedule: scheduled_time,
      class_name: 'MyTaskWorker',
      args: text,
      switch_value: params[:switch_value],
      vacan: params[:vacan],
      pub: params[:pub]
    )

    if task.persisted?
      puts "task.persisted"
      telusname = current_user.telegramid 
      Sidekiq.set_schedule("dynamic_task_#{uniqid}", {
        'at' => scheduled_time,           # Время выполнения задачи
        'class' => 'MyTaskWorker',        # Класс воркера
        'args' => [uniqid, text, telusname]                   # Аргументы для воркера
        # 'persist' => true                  # Сохраняем расписание в Redis
      })
      render plain: "Task scheduled for #{scheduled_time}"
    else
      render plain: "Failed to schedule task", status: :unprocessable_entity
    end
  end
      # Добавление задания в Sidekiq

  def unschedule_task
    task = current_user.scheduled_tasks.find_by(name: params[:name])
    # task = ScheduledTask.find_by(name: uniqid) 
    if task
      # Удаление задания из базы данных
      task.destroy

      # Удаление задания из Sidekiq
      Sidekiq.remove_schedule( "dynamic_task_#{params[:name]}")
      
      render plain: "Task unscheduled"
    else
      render plain: "Task not found", status: :not_found
    end
  end

  private

  # def set_user
  #   @user = User.find(params[:user_id])
  # end
end