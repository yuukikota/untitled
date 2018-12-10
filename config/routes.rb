Rails.application.routes.draw do

  devise_for :accounts
  resources :recruitments
  resources :comments
  resources :chat_comments
  resources :accounts
  resources :entry_chats
  resources :chats
  # root 'home#index'
  root 'mains#index'
  get 'home/:acc_id', to: 'home#show', as: :account_show
  get '/mains/log/:id', to: 'mains#login', as: 'mains_login'
  get '/mains/home', to: 'mains#home'
  get '/mains/button/:id', to: 'mains#button', as: 'mains_button'
  get '/acc_views', to: 'acc_views#index'
  get '/jumps/:id', to: 'jumps#index', as: 'jumps'
  get '/members', to: 'members#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
