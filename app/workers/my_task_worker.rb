require 'sidekiq-scheduler'
require 'net/http'
require 'uri'

class MyTaskWorker
  include Sidekiq::Worker

  def perform(uniqid, text)
    # user = User.find_by(id: user_id)
    # telegramid = user.telegramid
    # telegramusername = user.telegramusername
    # puts "uniqid"
    para = "sadfasfasfasfasf"
    # puts "!!!!!!!!!!!!!!!!!!!!!!----------000000--------!!!!!!!!!!!!!!!!!!!!!!!!!"
    # 'https://api.telegram.org/bot5531512315:AAHmGCiQQQfdVzQrcja0c9woh5TxrrYldk8/sendMessage?chat_id=199874565&text='+para 
   url = "https://api.telegram.org/bot5531512315:AAHmGCiQQQfdVzQrcja0c9woh5TxrrYldk8/sendMessage?chat_id=199874565&text=#{para}"

    # Выполнение HTTP GET-запроса
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
     Sidekiq::Scheduler.remove_schedule("dynamic_task_#{uniqid}")
    # Вывод результата
    puts "Response: #{response.body}"
  end
end
