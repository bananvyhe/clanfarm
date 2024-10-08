class MyTaskWorker
  include Sidekiq::Worker

  def perform(*args)
    # user = User.find_by(id: user_id)
    # telegramid = user.telegramid
    # telegramusername = user.telegramusername
      puts "!!!!!!!!!!!!!!!!!!!!!!----------000000--------!!!!!!!!!!!!!!!!!!!!!!!!!"
     # 'https://api.telegram.org/bot5531512315:AAHmGCiQQQfdVzQrcja0c9woh5TxrrYldk8/sendMessage?chat_id=199874565&text='+para 
  end
end
