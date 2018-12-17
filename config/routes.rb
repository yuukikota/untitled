Rails.application.routes.draw do

  resources :bookmarks, only: [:create, :destroy]
#  get "/inform" => "inform#gamen_sentaku"
#  get "inform/hatsugen_inf"
#  get "inform/hatsugen_inf/:ht11" => "inform#toukou"
#  get "inform/hatsugen_inf/:re_id" => "inform#toukou"
#  get "inform/toukou" => "inform"
#  get "/b_inform/bosyuu_inf"
#  get "b_inform/:ht22" => "b_inform#toukou"
#  get "b_inform/:re_id" => "b_inform#toukou"
#  get "b_inform/toukou" => "b_inform"

  devise_for :accounts, :controllers =>{
      :registrations => 'accounts/registrations'
  }

  devise_scope :account do
    post '/accounts/sign_up/confirm', to: 'accounts/registrations#confirm'
  end

  resources :recruitments, only: [ :edit, :update, :create, :destroy ]
  post '/recruitments/:id', to: 'recruitments#update', constraints: {id: /[0-9]+/ }
  # 返信追加読み込み
  get '/recruitments/edit/add/:id/:size/', to: 'recruitments#add_result', as: :results_add, constraints: { id:/[0-9]+/, size: /[0-9]+/ }

  # 返信生成削除
  resources :comments, only: [ :create, :destroy ]
  get '/comments/index/:recruitment_id', to: 'comments#index', as: :comments_index, constraints: { recruitment_id: /[0-9]+/ }
  # 返信追加読み込み
  get '/comments/index/add/:recruitment_id/:offset_time', to: 'comments#add_index', as: :comments_add, constraints: { recruitment_id:/[0-9]+/ }
  resources :chat_comments
  resources :entry_chats, only: [:create, :destroy]
  # チャット有り結果選択
  get '/entry_chats/new/:p_com_id', to: 'entry_chats#new', as: :new_entry_chats, constraints: { p_com_id: /[0-9]+/ }
  # 返信追加読み込み
  get '/entry_chats/new/add/:p_com_id/:size/', to: 'entry_chats#add_result', as: :results_chat_add, constraints: { p_com_id:/[0-9]+/, size: /[0-9]+/ }

  resources :pictures

  root 'mains#index'

  get 'home/:acc_id', to: 'home#show', as: :account_show
  get '/home/button/:id', to: 'home#button', as: 'home_button'

  post '/' => 'tags#update'#タグ検索フォーム

  get '/mains/button/:id', to: 'mains#button', as: 'mains_button'
  get '/mains/index/add/:size', to: 'mains#add_index', as: :mains_add, constraints: { size: /[0-9]+/ }
  get '/members', to: 'members#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/univtag/list', to: 'univtag#list' #タグ取得用

  get '/verify/recruit', to: 'verify#recruit' #検証用
end
