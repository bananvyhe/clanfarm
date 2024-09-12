
# Sidekiq::Extensions.enable_delay!

    if Rails.env.development?
      Sidekiq.configure_server do |config|
        config.redis = { url: 'redis://127.0.0.1:6379/0', namespace: "sidekiq_farmspot" }
      end
      Sidekiq.configure_client do |config|
        config.redis = { url: 'redis://127.0.0.1:6379/0', namespace: "sidekiq_farmspot" }
      end
    else
      Sidekiq.configure_server do |config|
        config.redis = { url: 'redis://127.0.0.1:6380/0', namespace: "sidekiq_farmspot" }
      end
      Sidekiq.configure_client do |config|
        config.redis = { url: 'redis://127.0.0.1:6380/0', namespace: "sidekiq_farmspot" }
      end
    end
 