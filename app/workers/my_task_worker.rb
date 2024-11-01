require 'sidekiq-scheduler'
require 'net/http'
require 'uri'

class MyTaskWorker
  include Sidekiq::Worker

  def perform(uniqid, text, telusname)
    encoded_text = ERB::Util.url_encode(text)
    # encoded_text = URI.encode_www_form_component(text)
    # puts "!!!!!!!!!!!!!!!!!!!!!!----------000000--------!!!!!!!!!!!!!!!!!!!!!!!!!"
    # 'https://api.telegram.org/bot5531512315:AAHmGCiQQQfdVzQrcja0c9woh5TxrrYldk8/sendMessage?chat_id=199874565&text='+para 
   url = "https://api.telegram.org/bot5531512315:AAHmGCiQQQfdVzQrcja0c9woh5TxrrYldk8/sendMessage?chat_id=#{telusname}&text=#{encoded_text}"

    # Выполнение HTTP GET-запроса
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    Sidekiq.remove_schedule("dynamic_task_#{uniqid}")
    task = ScheduledTask.find_by(name: uniqid) # Предполагается, что у вас есть поле `uniqid`
    task.destroy if task
    # Вывод результата
    puts "Response: #{response.body}"
  end
end
