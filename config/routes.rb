Rails.application.routes.draw do
 get "welcome/index"
 root to: "welcome#index"
 get :news, to: "news#index" 
end
