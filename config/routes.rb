Rails.application.routes.draw do

  devise_for :accounts, :controllers =>{
      :registrations => :registrations
  }
  resources :recruitments
  resources :comments
  resources :chat_comments
  resources :entry_chats
  resources :chats
  root 'mains#index'
  get 'home/:acc_id', to: 'home#show', as: :account_show
  get '/mains/button/:id', to: 'mains#button', as: 'mains_button'
  get '/jumps/:id', to: 'jumps#index', as: 'jumps'
  get '/members', to: 'members#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
