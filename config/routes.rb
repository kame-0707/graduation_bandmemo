Rails.application.routes.draw do
  root "static_pages#top"
  resources :summaries, only: %i[new create index show edit update destroy]
  resources :users, only: %i[new create]

  resources :voices, only: %i[new create index show edit update destroy]
  resources :spots, only: %i[new create index show edit update destroy]
  resources :groups, only: %i[new create index show edit update destroy] do
    resources :group_users, only: %i[create destroy]
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'oauths/oauth'
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
