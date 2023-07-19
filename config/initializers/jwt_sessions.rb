# JWTSessions.algorithm = 'HS256'
JWTSessions.encryption_key = Rails.application.secret_key_base
JWTSessions.token_store = :redis, { 
	redis_url: "redis://127.0.0.1:6379",
	pool_size: Integer(ENV.fetch("RAILS_MAX_THREADS", 25))
}
JWTSessions.access_exp_time = 1209600
# JWTSessions.access_exp_time = 20
# JWTSessions.refresh_exp_time = 604800 # 1 week in seconds