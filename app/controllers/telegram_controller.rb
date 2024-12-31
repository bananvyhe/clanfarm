class TelegramController < ApplicationController
  skip_before_action :verify_authenticity_token

  def webhook
    update = JSON.parse(request.body.read)

    # Проверяем, что это callback_query
    if update['callback_query']
      handle_callback_query(update['callback_query'])
    elsif update['message']
      handle_message(update['message'])
    end

    head :ok
  end

  private

  def handle_callback_query(callback_query)
    data = callback_query['data']
    chat_id = callback_query['message']['chat']['id']

    # Проверяем данные callback_data
    if data.start_with?("mark_as_read:")
      uniqid = data.split(":").last
      mark_task_as_read(uniqid, chat_id)
    end
  end

  def mark_task_as_read(uniqid, chat_id)
    task = ScheduledTask.find_by(name: uniqid)
    if task
      task.update(read: true) # Добавьте поле `read` в модель ScheduledTask
      send_message(chat_id, "Задача #{uniqid} отмечена как прочитанная.")
    else
      send_message(chat_id, "Задача #{uniqid} не найдена.")
    end
  end

  def send_message(chat_id, text)
    url = "https://api.telegram.org/bot#{ENV['TELEGRAM_BOT_TOKEN']}/sendMessage"
    message = { chat_id: chat_id, text: text }
    uri = URI.parse(url)
    Net::HTTP.post(uri, message.to_json, "Content-Type" => "application/json")
  end
end
