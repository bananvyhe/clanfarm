require 'sidekiq-scheduler'
require 'net/http'
require 'uri'

class MyTaskWorker
  include Sidekiq::Worker
  MAX_RETRIES = 3

  def perform(uniqid, text, telusname)
    # Отправляем сообщение в Telegram
    send_message(telusname, text, uniqid)

    # Находим задачу в базе данных
    task = ScheduledTask.find_by(name: uniqid)
    return unless task

    # Проверяем количество попыток
    if task.retries >= MAX_RETRIES
      puts "Max retries reached for task #{uniqid}. Stopping rescheduling."
      return
    end

    # Увеличиваем счетчик попыток
    task.update(retries: task.retries + 1)

    # Добавляем 2 минуты к текущему времени
    new_scheduled_time = Time.now.utc + 2.minutes

    # Обновляем время выполнения в базе данных
    task.update(schedule: new_scheduled_time.iso8601)

    # Перепланируем задачу в Sidekiq
    Sidekiq.set_schedule("dynamic_task_#{uniqid}", {
      'at' => new_scheduled_time.iso8601,
      'class' => 'MyTaskWorker',
      'args' => [uniqid, text, telusname]
    })

    puts "Task #{uniqid} rescheduled for #{new_scheduled_time}, attempt #{task.retries}"
  end

  private

  def send_message(telusname, text, uniqid)
    encoded_text = ERB::Util.url_encode(text)
    # url = "https://api.telegram.org/bot#{ENV['TELEGRAM_BOT_TOKEN']}/sendMessage"
    url = "https://api.telegram.org/bot5531512315:AAHmGCiQQQfdVzQrcja0c9woh5TxrrYldk8/sendMessage"
    message = {
      chat_id: telusname,
      text: text,
      reply_markup: {
        inline_keyboard: [
          [{ text: "Отметить прочитанным", callback_data: "mark_as_read:#{uniqid}" }]
        ]
      }
    }

    uri = URI.parse(url)
    Net::HTTP.post(uri, message.to_json, "Content-Type" => "application/json")
  end

  
end

# require 'sidekiq-scheduler'
# require 'net/http'
# require 'uri'

# class MyTaskWorker
#   include Sidekiq::Worker

#   def perform(uniqid, text, telusname)
#     encoded_text = ERB::Util.url_encode(text)
 
#    # url = "https://api.telegram.org/bot5531512315:AAHmGCiQQQfdVzQrcja0c9woh5TxrrYldk8/sendMessage?chat_id=#{telusname}&text=#{encoded_text}"
#     url = "https://api.telegram.org/bot5531512315:AAHmGCiQQQfdVzQrcja0c9woh5TxrrYldk8/sendMessage"

#   message = {
#     chat_id: telusname,
#     text: text,
#     reply_markup: {
#       inline_keyboard: [
#         [{ text: "Отметить прочитанным", callback_data: "mark_as_read" }]
#       ]
#     }
#   }
#      # Выполнение HTTP GET-запроса
#     uri = URI.parse(url)
#     response = Net::HTTP.get_response(uri)
#     Net::HTTP.post(uri, message.to_json, "Content-Type" => "application/json")
#     Sidekiq.remove_schedule("dynamic_task_#{uniqid}")
#     task = ScheduledTask.find_by(name: uniqid) # Предполагается, что у вас есть поле `uniqid`
#     task.destroy if task
#     # Вывод результата
#     puts "Response: #{response.body}" 
 
#   end
# end
