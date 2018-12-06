Rails.application.routes.draw do

  devise_for :accounts
  root 'home#index'
  get 'home/:acc_id', to: 'home#show', as: :account_show
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
