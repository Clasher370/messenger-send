Rails.application.routes.draw do
  post '/message', to: 'messages#create'
end
