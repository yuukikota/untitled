Rails.application.routes.draw do

  resources :photos
  resources :pictures
  get "/inform" => "inform#gamen_sentaku"
  get "inform/hatsugen_inf"
  get "inform/hatsugen_inf/:ht11" => "inform#toukou"
  get "inform/hatsugen_inf/:re_id" => "inform#toukou"
  get "inform/toukou" => "inform"
  get "/b_inform/bosyuu_inf"
  get "b_inform/:ht22" => "b_inform#toukou"
  get "b_inform/:re_id" => "b_inform#toukou"
  get "b_inform/toukou" => "inform"

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

  get 'tags/list', to: 'tags#list'
  post 'tags/list'=> 'tags#update'

  get '/mains/button/:id', to: 'mains#button', as: 'mains_button'
  get '/jumps/:id', to: 'jumps#index', as: 'jumps'
  get '/members', to: 'members#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
