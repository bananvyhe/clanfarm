# config/initializers/redis.rb

require 'redis'

# redis_config = Rails.application.config_for(:redis)

# $redis = Redis.new(url: redis_config['url'], pool_size: 20) # Set the desired pool size
redis_url = 'redis://127.0.0.1:6379' # Update with your Redis URL

# Create a Redis connection pool with a desired size
$redis = ConnectionPool.new(size: 40) do
  Redis.new(url: redis_url)
end