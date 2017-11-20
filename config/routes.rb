Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  post '/message', to: 'messages#create'
end
