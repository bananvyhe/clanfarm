
Sidekiq::Extensions.enable_delay!
Sidekiq.configure_server do |config|
 config.redis = Rails.env.production? ? 
                  { url: 'redis://127.0.0.1:6380/sidekiq_farm', namespace: 'sidekiq_farmspot' } :
                  { url: 'redis://127.0.0.1:6379/sidekiq_farm', namespace: 'sidekiq_farmspot' }


	# config.redis = { url: 'redis://127.0.0.1:6379/sidekiq_farm', namespace: "sidekiq_farmspot" }
end

Sidekiq.configure_client do |config|
 config.redis = Rails.env.production? ? 
                  { url: 'redis://127.0.0.1:6380/sidekiq_farm', namespace: 'sidekiq_farmspot' } :
                  { url: 'redis://127.0.0.1:6379/sidekiq_farm', namespace: 'sidekiq_farmspot' }
	# config.redis = { url: 'redis://127.0.0.1:6379/sidekiq_farm', namespace: "sidekiq_farmspot" }
end
