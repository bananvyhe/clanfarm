Rails.application.routes.draw do
 get "welcome/index"
 root to: "welcome#index"
 get :news, to: "news#index" 
 post :fullnews, to: "news#fullnews"
 post :news, to: "news#create"
 require "sidekiq/web"
  Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  	    login_hash = ::Digest::SHA256.hexdigest(username)
    password_hash = ::Digest::SHA256.hexdigest(password)

    ActiveSupport::SecurityUtils.secure_compare(login_hash, ::Digest::SHA256.hexdigest(Rails.application.credentials.username)) &
    ActiveSupport::SecurityUtils.secure_compare(password_hash, ::Digest::SHA256.hexdigest(Rails.application.credentials.password))
  end # if Rails.env.production?
  mount Sidekiq::Web, at: "/sidekiq"
end
