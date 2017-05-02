Rails.application.routes.draw do
  get '/chats', to: 'chats#index', as: 'chats'
  get '/chats/:channel/new_message', to: 'chats#new_message', as: 'new_message'
  post '/chats/:channel/new_message', to: 'chats#send_message', as:'send_message'
end
