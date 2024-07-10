Rails.application.routes.draw do
  get 'profiles/index'
  root "static_pages#top"

  resources :users, only: %i[new create]

  resources :spots, only: %i[new create index show edit update destroy]
  resources :groups, only: %i[new create index show edit update destroy] do
    resources :summaries, only: %i[new create index show edit update destroy]
    resources :voices, only: %i[new create index show edit update destroy]
    resource :permits, only: [:create, :destroy]
    resource :group_users, only: %i[create destroy]
  end

  # createアクションとdestroyアクションとパスの名前が被ってしまうため、判別しやすいようにパスの名前を「permits_path」に指定
  get "groups/:id/permits" => "groups#permits", as: :permits

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'oauths/oauth'
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
