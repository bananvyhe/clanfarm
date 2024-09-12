# config/initializers/redis.rb

# Assuming you are using the default Redis URL (redis://localhost:6379/0)
# If you have a different Redis configuration, adjust accordingly.

redis_config = {
  url: ENV['redis://127.0.0.1:6379'], # Set your Redis URL here, e.g., 'redis://localhost:6379/0'
  pool_size: 30 # Set your desired connection pool size here
}

Redis.current = ConnectionPool.new(size: redis_config[:pool_size]) do
  Redis.new(url: redis_config[:url])
end

# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://localhost:6379/0', namespace: 'farmspot' }
# end
